{
	"patcher" : 	{
		"fileversion" : 1,
		"appversion" : 		{
			"major" : 8,
			"minor" : 6,
			"revision" : 0,
			"architecture" : "x64",
			"modernui" : 1
		},
		"classnamespace" : "box",
		"rect" : [ 100, 100, 700, 500 ],
		"bglocked" : 0,
		"openinpresentation" : 1,
		"default_fontsize" : 12.0,
		"default_fontface" : 0,
		"default_fontname" : "Arial",
		"gridonopen" : 1,
		"gridsize" : [ 15.0, 15.0 ],
		"gridsnaponopen" : 1,
		"objectsnaponopen" : 1,
		"statusbarvisible" : 2,
		"toolbarvisible" : 1,
		"lefttoolbarpinned" : 0,
		"toptoolbarpinned" : 0,
		"righttoolbarpinned" : 0,
		"bottomtoolbarpinned" : 0,
		"toolbars_unpinned_last_save" : 0,
		"tallnewobj" : 0,
		"boxanimatetime" : 200,
		"enablehscroll" : 1,
		"enablevscroll" : 1,
		"devicewidth" : 0.0,
		"description" : "Huron Average Voiceleading",
		"digest" : "",
		"tags" : "",
		"style" : "",
		"subpatcher_template" : "",
		"assistshowspatchername" : 0,
		"boxes" : [ 
			{
				"box" : 				{
					"id" : "obj-panel",
					"maxclass" : "panel",
					"mode" : 0,
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 450.0, 30.0, 200.0, 85.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 0.0, 0.0, 200.0, 85.0 ],
					"bgfillcolor" : 					{
						"type" : "color",
						"color" : [ 0.2, 0.2, 0.2, 1.0 ]
					}
				}
			},
			{
				"box" : 				{
					"fontface" : 1,
					"fontsize" : 11.0,
					"id" : "obj-title",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 450.0, 130.0, 200.0, 19.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 10.0, 8.0, 180.0, 19.0 ],
					"text" : "HURON VOICELEADING",
					"textcolor" : [ 0.9, 0.9, 0.9, 1.0 ]
				}
			},
			{
				"box" : 				{
					"fontsize" : 10.0,
					"id" : "obj-label-voice",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 450.0, 160.0, 80.0, 18.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 10.0, 30.0, 65.0, 18.0 ],
					"text" : "Input Voice",
					"textcolor" : [ 0.7, 0.7, 0.7, 1.0 ]
				}
			},
			{
				"box" : 				{
					"fontsize" : 10.0,
					"id" : "obj-label-sel",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 550.0, 160.0, 80.0, 18.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 105.0, 30.0, 65.0, 18.0 ],
					"text" : "Selection",
					"textcolor" : [ 0.7, 0.7, 0.7, 1.0 ]
				}
			},
			{
				"box" : 				{
					"id" : "obj-voice-menu",
					"items" : [ "bass", ",", "tenor", ",", "alto", ",", "soprano" ],
					"maxclass" : "umenu",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "int", "", "" ],
					"parameter_enable" : 1,
					"patching_rect" : [ 450.0, 190.0, 80.0, 22.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 10.0, 50.0, 85.0, 22.0 ],
					"saved_attribute_attributes" : 					{
						"valueof" : 						{
							"parameter_enum" : [ "bass", "tenor", "alto", "soprano" ],
							"parameter_longname" : "voice_mode",
							"parameter_mmax" : 3,
							"parameter_modmode" : 0,
							"parameter_shortname" : "Voice",
							"parameter_type" : 2
						}
					},
					"varname" : "voice_mode"
				}
			},
			{
				"box" : 				{
					"id" : "obj-sel-menu",
					"items" : [ "random", ",", "rr up", ",", "rr down" ],
					"maxclass" : "umenu",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "int", "", "" ],
					"parameter_enable" : 1,
					"patching_rect" : [ 550.0, 190.0, 80.0, 22.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 105.0, 50.0, 85.0, 22.0 ],
					"saved_attribute_attributes" : 					{
						"valueof" : 						{
							"parameter_enum" : [ "random", "rr up", "rr down" ],
							"parameter_longname" : "selection_mode",
							"parameter_mmax" : 2,
							"parameter_modmode" : 0,
							"parameter_shortname" : "Selection",
							"parameter_type" : 2
						}
					},
					"varname" : "selection_mode"
				}
			},
			{
				"box" : 				{
					"id" : "obj-midiin",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 50.0, 30.0, 50.0, 22.0 ],
					"text" : "midiin"
				}
			},
			{
				"box" : 				{
					"id" : "obj-midiparse",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 8,
					"outlettype" : [ "", "", "", "int", "int", "int", "int", "" ],
					"patching_rect" : [ 50.0, 70.0, 97.0, 22.0 ],
					"text" : "midiparse"
				}
			},
			{
				"box" : 				{
					"id" : "obj-js",
					"maxclass" : "newobj",
					"numinlets" : 4,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 50.0, 110.0, 180.0, 22.0 ],
					"text" : "js huron_voiceleading.js"
				}
			},
			{
				"box" : 				{
					"id" : "obj-unpack-out",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 5,
					"outlettype" : [ "int", "int", "int", "int", "int" ],
					"patching_rect" : [ 50.0, 150.0, 200.0, 22.0 ],
					"text" : "unpack 0 0 0 0 0"
				}
			},
			{
				"box" : 				{
					"id" : "obj-pack1",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 50.0, 190.0, 55.0, 22.0 ],
					"text" : "pack 0 0"
				}
			},
			{
				"box" : 				{
					"id" : "obj-pack2",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 120.0, 190.0, 55.0, 22.0 ],
					"text" : "pack 0 0"
				}
			},
			{
				"box" : 				{
					"id" : "obj-pack3",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 190.0, 190.0, 55.0, 22.0 ],
					"text" : "pack 0 0"
				}
			},
			{
				"box" : 				{
					"id" : "obj-pack4",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 260.0, 190.0, 55.0, 22.0 ],
					"text" : "pack 0 0"
				}
			},
			{
				"box" : 				{
					"id" : "obj-fmt1",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "int" ],
					"patching_rect" : [ 50.0, 230.0, 70.0, 22.0 ],
					"text" : "midiformat"
				}
			},
			{
				"box" : 				{
					"id" : "obj-fmt2",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "int" ],
					"patching_rect" : [ 130.0, 230.0, 70.0, 22.0 ],
					"text" : "midiformat"
				}
			},
			{
				"box" : 				{
					"id" : "obj-fmt3",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "int" ],
					"patching_rect" : [ 210.0, 230.0, 70.0, 22.0 ],
					"text" : "midiformat"
				}
			},
			{
				"box" : 				{
					"id" : "obj-fmt4",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "int" ],
					"patching_rect" : [ 290.0, 230.0, 70.0, 22.0 ],
					"text" : "midiformat"
				}
			},
			{
				"box" : 				{
					"id" : "obj-midiout",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 150.0, 280.0, 55.0, 22.0 ],
					"text" : "midiout"
				}
			}
		],
		"lines" : [ 
			{
				"patchline" : 				{
					"destination" : [ "obj-midiparse", 0 ],
					"source" : [ "obj-midiin", 0 ]
				}
			},
			{
				"patchline" : 				{
					"destination" : [ "obj-js", 0 ],
					"source" : [ "obj-midiparse", 0 ]
				}
			},
			{
				"patchline" : 				{
					"destination" : [ "obj-js", 1 ],
					"source" : [ "obj-voice-menu", 0 ]
				}
			},
			{
				"patchline" : 				{
					"destination" : [ "obj-js", 2 ],
					"source" : [ "obj-sel-menu", 0 ]
				}
			},
			{
				"patchline" : 				{
					"destination" : [ "obj-unpack-out", 0 ],
					"source" : [ "obj-js", 0 ]
				}
			},
			{
				"patchline" : 				{
					"destination" : [ "obj-pack1", 0 ],
					"source" : [ "obj-unpack-out", 0 ]
				}
			},
			{
				"patchline" : 				{
					"destination" : [ "obj-pack1", 1 ],
					"source" : [ "obj-unpack-out", 4 ]
				}
			},
			{
				"patchline" : 				{
					"destination" : [ "obj-pack2", 0 ],
					"source" : [ "obj-unpack-out", 1 ]
				}
			},
			{
				"patchline" : 				{
					"destination" : [ "obj-pack2", 1 ],
					"source" : [ "obj-unpack-out", 4 ]
				}
			},
			{
				"patchline" : 				{
					"destination" : [ "obj-pack3", 0 ],
					"source" : [ "obj-unpack-out", 2 ]
				}
			},
			{
				"patchline" : 				{
					"destination" : [ "obj-pack3", 1 ],
					"source" : [ "obj-unpack-out", 4 ]
				}
			},
			{
				"patchline" : 				{
					"destination" : [ "obj-pack4", 0 ],
					"source" : [ "obj-unpack-out", 3 ]
				}
			},
			{
				"patchline" : 				{
					"destination" : [ "obj-pack4", 1 ],
					"source" : [ "obj-unpack-out", 4 ]
				}
			},
			{
				"patchline" : 				{
					"destination" : [ "obj-fmt1", 0 ],
					"source" : [ "obj-pack1", 0 ]
				}
			},
			{
				"patchline" : 				{
					"destination" : [ "obj-fmt2", 0 ],
					"source" : [ "obj-pack2", 0 ]
				}
			},
			{
				"patchline" : 				{
					"destination" : [ "obj-fmt3", 0 ],
					"source" : [ "obj-pack3", 0 ]
				}
			},
			{
				"patchline" : 				{
					"destination" : [ "obj-fmt4", 0 ],
					"source" : [ "obj-pack4", 0 ]
				}
			},
			{
				"patchline" : 				{
					"destination" : [ "obj-midiout", 0 ],
					"source" : [ "obj-fmt1", 0 ]
				}
			},
			{
				"patchline" : 				{
					"destination" : [ "obj-midiout", 0 ],
					"source" : [ "obj-fmt2", 0 ]
				}
			},
			{
				"patchline" : 				{
					"destination" : [ "obj-midiout", 0 ],
					"source" : [ "obj-fmt3", 0 ]
				}
			},
			{
				"patchline" : 				{
					"destination" : [ "obj-midiout", 0 ],
					"source" : [ "obj-fmt4", 0 ]
				}
			}
		]
	}
}
