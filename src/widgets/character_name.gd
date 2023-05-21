extends "res://src/widgets/slideshow_panel.gd"


func _on_line_edit_text_changed(new_text : String) -> void:
	%Next.disabled = new_text == "";

func _on_next_pressed() -> void:
	Global.c_name = %LineEdit.text;

func _on_line_edit_text_submitted() -> void:
	if %LineEdit.text != "": NextPressed.emit();
	_on_next_pressed();
