extends Node


const CONFIG_PATH : String = "user://config.cfg";
const UNSAVED_CHANGES_DIALOG : PackedScene = preload("res://src/widgets/unsaved_changes.tscn");
const MAIN_SCENE : PackedScene = preload("res://src/scenes/main.tscn");

enum ScanFilter {
	FOLDERS,
	FILES,
	BOTH,
}

var c_name : String = "";
var c_greeting : String = "";
var c_personality : String = "";
var c_world_scenario : String = "";
var c_example_dialogue : String = "";

var characters_location : String = "";
var your_name : String = "";

var unsaved_changes : bool = false;


func _ready() -> void:
	get_tree().auto_accept_quit = false;
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
			
	characters_location = c.get_value("Paths", "CharactersLocation", "user://");
	your_name = c.get_value("User", "YourName", "You");
	return 0;
	
func create_config() -> int:
	print("Creating new config...");
	var c : ConfigFile = ConfigFile.new();
	c.set_value("Paths", "CharactersLocation", "user://");
	c.set_value("User", "YourName", "You");
	return c.save(CONFIG_PATH);

func _notification(what : int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		var c : ConfigFile = ConfigFile.new();
		c.load(CONFIG_PATH);
		c.set_value("Paths", "CharactersLocation", characters_location);
		c.set_value("User", "YourName", your_name);
		c.save(CONFIG_PATH);
		if unsaved_changes:
			var d : ConfirmationDialog = UNSAVED_CHANGES_DIALOG.instantiate();
			d.connect("confirmed", get_tree().quit);
			add_sibling(d);
		else:
			get_tree().quit();
