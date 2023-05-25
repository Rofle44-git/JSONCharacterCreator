extends "res://src/widgets/slideshow_panel.gd"


func _on_text_edit_text_changed() -> void:
	%Next.disabled = %TextEdit.text == "" || %TextEdit.text.length() > 550;

func _on_next_pressed() -> void:
	Global.c_personality = %TextEdit.text;
