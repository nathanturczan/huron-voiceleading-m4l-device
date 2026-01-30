# Huron Voiceleading

A Max for Live MIDI effect that transforms single notes into four-voice harmonic voicings based on David Huron's musicological research.

![David Huron Average Voice Leading](David%20Huron%20Average%20Voice%20Leading.png)

## Overview

Play any note and get scientifically-derived four-part harmony (bass, tenor, alto, soprano) with historically accurate voice spacing. The interval data comes from statistical analysis of over 10,000 four-note sonorities from Bach keyboard works and Haydn string quartets.

The key insight from Huron's research: interval spacing naturally decreases as pitch rises. Lower registers use wider intervals to avoid muddiness, while upper registers use closer spacing for acoustic clarity. This device encodes those principles directly.

## Installation

1. Download `Huron4.amxd` (or the numbered variant you prefer)
2. Place it in your Ableton Live User Library under `MIDI Effects`
3. Drag onto a MIDI track

## How It Works

### Voice Modes

The device operates in four voice modes, depending on which voice you want your input note to become:

| Mode | Input Range | Description |
|------|-------------|-------------|
| **Bass** | C2-C4 (MIDI 36-60) | Input becomes the bass note; other voices calculated above |
| **Tenor** | G3-E4 (MIDI 55-64) | Reverse lookup finds bass notes that place input in tenor |
| **Alto** | D#4-A4 (MIDI 63-69) | Reverse lookup for alto voice placement |
| **Soprano** | A4-D#5 (MIDI 69-75) | Reverse lookup for soprano voice placement |

### Selection Modes

When playing in non-bass modes, multiple voicing solutions may exist. Choose how to select among them:

- **Random** — Randomly selects from available solutions
- **Round-Robin Up** — Cycles sequentially upward through solutions
- **Round-Robin Down** — Cycles sequentially downward through solutions

### Auto Voice-Switching

When playing chromatically and exceeding the current voice's range, the device automatically steps to the adjacent voice. The UI updates to reflect voice changes.

## Files

| File | Description |
|------|-------------|
| `Huron4.amxd` | Main Max for Live device (recommended) |
| `huron_voiceleading.js` | JavaScript engine with Huron interval data |
| `huron_m4l_v5.maxpat` | Max patcher (underlying patch) |
| `Huron.amxd`, `Huron2.amxd`, `Huron3.amxd` | Earlier versions |
| `average_voiceleading.adg` | Ableton device group |

## Technical Details

The JavaScript engine contains:
- Forward lookup table: 25 bass notes (C2-C4) with corresponding tenor/alto/soprano intervals
- Reverse lookup tables for tenor, alto, and soprano modes
- Voice range validation
- Note-off tracking to prevent stuck notes
- Gap-filling using next-higher note's voicing for missing data points

All four voice notes output simultaneously on the same MIDI channel with preserved input velocity.

## References

- Huron, D. (2001). [Tone and Voice: A Derivation of the Rules of Voice-Leading from Perceptual Principles](Derivation%20of%20Rules%20of%20Voice-leading%20from%20Perceptual%20Principles.pdf). *Music Perception*, 19(1), 1-64.

## About the Author

**Nathan Turczan** is a composer and creative technologist based in Los Angeles, CA.

- Website: [nathanturczan.com](https://nathanturczan.com)
- Instagram: [@nathan_turczan](https://instagram.com/nathan_turczan)
- Email: nathanturczan@gmail.com

## License

MIT License — free to use, modify, and distribute.
