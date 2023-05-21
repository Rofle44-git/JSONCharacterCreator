extends Node

func _ready() -> void:
	var f = FileAccess.open(OS.get_executable_path().get_base_dir().path_join("godot.txt"), FileAccess.WRITE)
	f.store_string(Engine.get_license_text())
	f.close()
	f = FileAccess.open(OS.get_executable_path().get_base_dir().path_join("third-party.txt"), FileAccess.WRITE)
	for key in Engine.get_license_info().values():
		f.store_string(key)
	f.close()
