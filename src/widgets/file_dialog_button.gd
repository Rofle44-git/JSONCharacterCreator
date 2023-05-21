extends HBoxContainer


func _ready() -> void:
	$Path.text = Global.save_location;

func _on_file_dialog_dir_selected(dir: String) -> void:
	_new_path(dir);
	$Path.text = dir;

func _new_path(path : String = "") -> void:
	Global.save_location = $Path.text if path == "" else path;
