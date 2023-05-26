extends Control


const SETTINGS : PackedScene = preload("res://src/scenes/settings.tscn");
const MANAGER : PackedScene = preload("res://src/scenes/manager.tscn");
const CREATOR : PackedScene = preload("res://src/scenes/creator.tscn");


func _on_settings_pressed() -> void:
	add_child(SETTINGS.instantiate());

func _on_manage_pressed() -> void:
	get_tree().change_scene_to_packed(MANAGER);

func _on_create_pressed() -> void:
	get_tree().change_scene_to_packed(CREATOR);
