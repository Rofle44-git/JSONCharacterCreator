extends "res://src/widgets/slideshow_panel.gd"


signal NewPressed;


func _on_save_pressed() -> void:
	var json_data : Dictionary = {
		"your_name": Global.your_name,
		"char_name": Global.c_name,
		"char_persona": Global.c_personality,
		"char_greeting": Global.c_greeting,
		"world_scenario": Global.c_world_scenario,
		"example_dialogue": Global.c_example_dialogue,
	};
	
	var f : FileAccess = FileAccess.open(Global.save_location.path_join(Global.c_name+".json"), FileAccess.WRITE);
	var str_data : String = JSON.stringify(json_data);
	f.store_string(str_data);
	f.close();
	%New.disabled = false;
	
	var c : ConfigFile = ConfigFile.new();
	c.load(Global.CONFIG_PATH);
	c.set_value("User", "UsedGayXTimes", c.get_value("User", "UsedGayXTimes", 0)+str_data.countn("gay"));
	c.save(Global.CONFIG_PATH);

func _on_new_pressed() -> void:
	get_tree().reload_current_scene();
