extends VBoxContainer


const CHAR_MESSAGE = preload("res://src/widgets/character_message.tscn");
const USER_MESSAGE = preload("res://src/widgets/user_message.tscn");

@export var character_limit : int;

var message_lengths : PackedInt32Array = [];
var total_messages_length : int;
var input_characters : int;

func _ready() -> void:
	get_window().focus_entered.connect(_on_window_focus_entered);
	update_limit_label();

func get_content() -> String:
	var data : String = "";
	for child in %Messages.get_children():
		data += child.get_content()+"\n";
	data = data.trim_suffix("\n");
	return data;

func update_messages_length() -> void:
	total_messages_length = 0;
	for length in message_lengths:
		total_messages_length += length;
	update_limit_label();

func update_limit_label() -> void:
	var from : int = total_messages_length+%LineEdit.text.length()+(9 if %LineEdit.text.length() > 0 else 0); 
	var to : int = character_limit;
	%Limit.text = "%s/%s" % [str(from).pad_zeros(ceil(Math.logn(to, 10))),to];
	%Limit.self_modulate.h = 0.333*clampf(Math.safe_div(to, from, false), 0.0, 1.0);
	
func _on_remove(from : int) -> void:
	var node : Node;
	for i in %Messages.get_child_count()-from:
		node = %Messages.get_child(%Messages.get_child_count()-1);
		message_lengths.remove_at(%Messages.get_child_count()-1);
		%Messages.remove_child(node);
		node.queue_free();
		update_messages_length();

func _on_line_edit_text_submitted(new_text : String) -> void:
	#Adding message
	%LineEdit.clear();
	var message : Message = USER_MESSAGE.instantiate() if %Messages.get_child_count() % 2 == 0 else CHAR_MESSAGE.instantiate();
	message.set_content(new_text);
	message.Remove.connect(_on_remove);
	%Messages.add_child(message);
	message_lengths.append(new_text.length()+9);
	update_messages_length(); 
	
	# Scroll down
	await get_tree().process_frame;
	%ScrollContainer.set_deferred("scroll_vertical", %ScrollContainer.get_v_scroll_bar().max_value);

func _on_window_focus_entered():
	if %AutoPaste.button_pressed:
		_on_line_edit_text_submitted(DisplayServer.clipboard_get());
