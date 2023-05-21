extends VBoxContainer


const CHAR_MESSAGE = preload("res://src/widgets/character_message.tscn");
const USER_MESSAGE = preload("res://src/widgets/user_message.tscn");


func get_content() -> String:
	var data : String = "";
	for child in %Messages.get_children():
		data += child.get_content()+"\n";
	data = data.trim_suffix("\n");
	return data;

func _on_remove(from : int) -> void:
	var node : Node;
	print("Attempting to remove from message ", from+1);
	for i in %Messages.get_child_count()-from:
		print("Removing message ", %Messages.get_child_count(), " with ", %Messages.get_child_count(), " messages in the tree.");
		node = %Messages.get_child(%Messages.get_child_count()-1);
		%Messages.remove_child(node);
		node.queue_free();

func _on_line_edit_text_submitted(new_text : String) -> void:
	%LineEdit.clear();
	var message : Message = USER_MESSAGE.instantiate() if %Messages.get_child_count() % 2 == 0 else CHAR_MESSAGE.instantiate();
	message.set_content(new_text);
	message.Remove.connect(_on_remove);
	%Messages.add_child(message);
	await %Messages.resized;
	%ScrollContainer.scroll_vertical = %Messages.size.y;
