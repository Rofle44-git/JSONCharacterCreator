extends Node


signal SubmitValues;


const CONFIG_PATH : String = "user://config.cfg";

var c_name : String = "";
var c_greeting : String = "";
var c_personality : String = "";
var c_world_scenario : String = "";
var c_example_dialogue : String = "";

var save_location : String = "";
var your_name : String = "";


func _ready() -> void:
	if load_config() != 0: get_tree().quit();
	print("Done.");

func load_config() -> int:
	print("Loading config...");
	var c : ConfigFile = ConfigFile.new();
	if c.load(CONFIG_PATH) != OK:
		print("Failed to load config.");
		if create_config() != OK:
			print("Failed to create config.");
			return 1;
	save_location = c.get_value("Paths", "SaveLocation", "user://");
	your_name = c.get_value("User", "YourName", "You");
	return 0;
	
func create_config() -> int:
	print("Creating new config...");
	var c : ConfigFile = ConfigFile.new();
	c.set_value("Paths", "SaveLocation", "user://");
	c.set_value("User", "YourName", "You");
	return c.save(CONFIG_PATH);

func _notification(what : int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		var c : ConfigFile = ConfigFile.new();
		c.set_value("Paths", "SaveLocation", save_location);
		c.set_value("User", "YourName", your_name);
