extends Control
class_name Message


signal Remove(from : int);

@export_enum("char", "user") var Sender : String;


func set_content(content : String) -> void:
	$PanelContainer/Text.text = content;

func get_content() -> String:
	return "{{%s}}: %s" % [Sender, $PanelContainer/Text.text];

func _on_remove_pressed() -> void:
	Remove.emit(get_index());
