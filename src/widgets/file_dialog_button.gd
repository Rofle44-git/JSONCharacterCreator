extends HBoxContainer


func _ready() -> void:
	$Path.text = Global.characters_location;

func set_text(text : String) -> void:
	$Path.text = text;

func get_text() -> String:
	return $Path.text;

func _on_file_dialog_dir_selected(dir: String) -> void:
	_new_path(dir);
	$Path.text = dir;

func _new_path(path : String = "") -> void:
	print("Set.")
	Global.characters_location = $Path.text if path == "" else path;
