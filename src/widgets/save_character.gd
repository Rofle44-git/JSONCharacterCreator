extends "res://src/widgets/slideshow_panel.gd"

signal NewPressed


func _on_save_pressed() -> void:
	var json_data : Dictionary = {
		"char_name": Global.c_name,
		"char_persona": Global.c_personality,
		"char_greeting": Global.c_greeting,
		"world_scenario": "",
		"example_dialogue": Global.c_example_dialogue,
	};
	print("JSON content:\n", json_data);
	
	var f : FileAccess = FileAccess.open(Global.save_location.path_join(Global.c_name+".json"), FileAccess.WRITE);
	f.store_string(JSON.stringify(json_data));
	f.close();
	%New.disabled = false;

func _on_new_pressed() -> void:
	get_tree().reload_current_scene();
