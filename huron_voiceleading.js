/*
    Huron Average Voiceleading
    Based on >10,000 four-note sonorities (Bach & Haydn)
    Range: C2-C4 (MIDI 36-60)
    Gaps filled using next higher note's voicing
    Auto voice-type switching when pitch exceeds current voice range
    
    Inlets:
      0: pitch (MIDI note number) or list [pitch, velocity]
      1: voice_mode (0=bass, 1=tenor, 2=alto, 3=soprano)
      2: selection_mode (0=random, 1=round-robin up, 2=round-robin down)
      3: velocity
    
    Outlets:
      0: list [bass, tenor, alto, soprano, velocity]
      1: voice_mode (int, sent when auto-switching)
*/

inlets = 4;
outlets = 2;

// Forward lookup: bass MIDI -> [tenor, alto, soprano] intervals
var huron_intervals = {
    36: [19, 28, 33],  // C2
    37: [22, 27, 33],  // C#2
    38: [22, 27, 33],  // D2
    39: [17, 24, 31],  // D#2
    40: [17, 24, 31],  // E2
    41: [16, 27, 33],  // F2
    42: [14, 21, 29],  // F#2
    43: [14, 21, 29],  // G2
    44: [11, 20, 27],  // G#2
    45: [11, 20, 27],  // A2
    46: [10, 18, 24],  // Bb2
    47: [10, 17, 25],  // B2
    48: [10, 17, 25],  // C3
    49: [8, 14, 23],   // C#3
    50: [8, 14, 23],   // D3
    51: [6, 13, 21],   // D#3
    52: [6, 13, 21],   // E3
    53: [6, 13, 21],   // F3
    54: [5, 11, 20],   // F#3
    55: [5, 11, 20],   // G3
    56: [4, 11, 18],   // Ab3
    57: [4, 9, 17],    // A3
    58: [4, 9, 17],    // Bb3
    59: [4, 9, 15],    // B3
    60: [4, 9, 15]     // C4
};

// Voice ranges (valid input pitches for each mode)
var voice_ranges = [
    {min: 36, max: 60},  // 0: bass
    {min: 55, max: 64},  // 1: tenor
    {min: 63, max: 69},  // 2: alto
    {min: 69, max: 75}   // 3: soprano
];

var voice_names = ["bass", "tenor", "alto", "soprano"];

// Build reverse lookups
var tenor_reverse = {};
var alto_reverse = {};
var soprano_reverse = {};

function build_reverse_lookups() {
    for (var bass = 36; bass <= 60; bass++) {
        if (!huron_intervals[bass]) continue;
        var intervals = huron_intervals[bass];
        var tenor = bass + intervals[0];
        var alto = bass + intervals[1];
        var soprano = bass + intervals[2];
        
        if (!tenor_reverse[tenor]) tenor_reverse[tenor] = [];
        tenor_reverse[tenor].push(bass);
        
        if (!alto_reverse[alto]) alto_reverse[alto] = [];
        alto_reverse[alto].push(bass);
        
        if (!soprano_reverse[soprano]) soprano_reverse[soprano] = [];
        soprano_reverse[soprano].push(bass);
    }
}

build_reverse_lookups();

// State
var voice_mode = 0;
var selection_mode = 0;
var current_velocity = 100;
var rr_counters = {};
var active_notes = {};

function msg_int(v) {
    if (inlet === 0) {
        process_pitch(v);
    } else if (inlet === 1) {
        voice_mode = v;
    } else if (inlet === 2) {
        selection_mode = v;
    } else if (inlet === 3) {
        current_velocity = v;
    }
}

function list() {
    var a = arrayfromargs(arguments);
    if (inlet === 0) {
        if (a.length >= 2) {
            current_velocity = a[1];
            process_pitch(a[0]);
        } else if (a.length === 1) {
            process_pitch(a[0]);
        }
    }
}

// Check if pitch is in a voice's range
function pitch_in_range(pitch, mode) {
    var range = voice_ranges[mode];
    return pitch >= range.min && pitch <= range.max;
}

// Find appropriate voice for pitch, stepping contiguously from current voice
function find_voice_for_pitch(pitch, current) {
    // If current voice can handle it, stay there
    if (pitch_in_range(pitch, current)) {
        return current;
    }
    
    var range = voice_ranges[current];
    
    // Pitch is above current range - step up through voices
    if (pitch > range.max) {
        for (var v = current + 1; v <= 3; v++) {
            if (pitch_in_range(pitch, v)) {
                return v;
            }
        }
    }
    
    // Pitch is below current range - step down through voices
    if (pitch < range.min) {
        for (var v = current - 1; v >= 0; v--) {
            if (pitch_in_range(pitch, v)) {
                return v;
            }
        }
    }
    
    // No voice can handle this pitch
    return -1;
}

function process_pitch(pitch) {
    if (current_velocity === 0) {
        handle_note_off(pitch);
        return;
    }
    
    // Auto-switch voice if needed
    var target_voice = find_voice_for_pitch(pitch, voice_mode);
    
    if (target_voice === -1) {
        post("huron: no voice can handle pitch " + pitch + "\n");
        return;
    }
    
    // Update voice mode if changed
    if (target_voice !== voice_mode) {
        post("huron: auto-switch " + voice_names[voice_mode] + " -> " + voice_names[target_voice] + "\n");
        voice_mode = target_voice;
        outlet(1, voice_mode);  // Update UI
    }
    
    var bass = null;
    
    if (voice_mode === 0) {
        // Bass mode - direct lookup
        bass = pitch;
    } else {
        // Reverse lookup for tenor/alto/soprano
        var reverse_table;
        if (voice_mode === 1) {
            reverse_table = tenor_reverse;
        } else if (voice_mode === 2) {
            reverse_table = alto_reverse;
        } else {
            reverse_table = soprano_reverse;
        }
        
        var candidates = reverse_table[pitch];
        if (!candidates || candidates.length === 0) {
            post("huron: no solution for " + voice_names[voice_mode] + " " + pitch + "\n");
            return;
        }
        
        bass = select_from_candidates(candidates, voice_mode, pitch);
    }
    
    var intervals = huron_intervals[bass];
    var tenor = bass + intervals[0];
    var alto = bass + intervals[1];
    var soprano = bass + intervals[2];
    
    active_notes[pitch] = [bass, tenor, alto, soprano];
    outlet(0, [bass, tenor, alto, soprano, current_velocity]);
}

function handle_note_off(pitch) {
    if (active_notes[pitch]) {
        var chord = active_notes[pitch];
        outlet(0, [chord[0], chord[1], chord[2], chord[3], 0]);
        delete active_notes[pitch];
    }
}

function select_from_candidates(candidates, mode, pitch) {
    if (candidates.length === 1) {
        return candidates[0];
    }
    
    if (selection_mode === 0) {
        return candidates[Math.floor(Math.random() * candidates.length)];
    } else {
        var key = mode + "_" + pitch;
        if (rr_counters[key] === undefined) {
            rr_counters[key] = 0;
        }
        
        var idx = rr_counters[key];
        var result = candidates[idx];
        
        if (selection_mode === 1) {
            rr_counters[key] = (idx + 1) % candidates.length;
        } else {
            rr_counters[key] = (idx - 1 + candidates.length) % candidates.length;
        }
        
        return result;
    }
}

function reset() {
    rr_counters = {};
    active_notes = {};
    post("huron: reset\n");
}

post("huron: loaded with auto-voice-switching\n");
post("huron: ranges - bass:36-60, tenor:55-64, alto:63-69, soprano:69-75\n");
