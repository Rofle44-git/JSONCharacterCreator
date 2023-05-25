extends Control


const SETTINGS : PackedScene = preload("res://src/scenes/settings.tscn");


func _on_settings_pressed() -> void:
	add_child(SETTINGS.instantiate());
