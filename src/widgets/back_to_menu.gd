extends MarginContainer


@export var check_unsaved_changes : bool = false;


func _on_button_pressed() -> void:
	if check_unsaved_changes and Global.unsaved_changes:
		var d : ConfirmationDialog = Global.UNSAVED_CHANGES_DIALOG.instantiate();
		d.connect("confirmed", change_scene);
		add_sibling(d);
		return;
	change_scene();

func change_scene() -> void:
	get_tree().call_deferred("change_scene_to_packed", Global.MAIN_SCENE);
