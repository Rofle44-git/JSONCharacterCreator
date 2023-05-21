extends "res://src/widgets/slideshow_panel.gd"


func _on_next_pressed() -> void:
	Global.c_example_dialogue = %DialogueEditor.get_content();
