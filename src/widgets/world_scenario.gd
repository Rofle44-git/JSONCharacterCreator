extends "res://src/widgets/slideshow_panel.gd"


func _on_next_pressed() -> void:
	Global.c_world_scenario = %TextEdit.text;
