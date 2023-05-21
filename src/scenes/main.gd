extends Control

var current_slide : int = 0;

func _ready() -> void:
	$CharacterName.connect("NextPressed", to_slide.bind(1));
	$CharacterGreeting.connect("PreviousPressed", to_slide.bind(0));
	$CharacterGreeting.connect("NextPressed", to_slide.bind(2));
	$CharacterPersonality.connect("PreviousPressed", to_slide.bind(1));
	$CharacterPersonality.connect("NextPressed", to_slide.bind(3));
	$ExampleDialogues.connect("PreviousPressed", to_slide.bind(2));
	$ExampleDialogues.connect("NextPressed", to_slide.bind(4));
	$SaveCharacter.connect("PreviousPressed", to_slide.bind(3));
	$SaveCharacter.connect("NewPressed", to_slide.bind(1));
	get_child(current_slide).focus();
	for child in get_children():
		child.visible = child == get_child(current_slide);

func to_slide(idx : int) -> void:
	current_slide = idx;
	get_child(idx).visible = true;
	for child in get_children():
		get_tree().create_tween()\
			.bind_node(child)\
			.set_ease(Tween.EASE_OUT)\
			.set_trans(Tween.TRANS_BACK)\
			.tween_property(child, "position", Vector2(60+600*child.get_index()-600*idx, 150), 0.3);
	
	get_child(idx).focus();
	
	await get_tree().create_timer(0.3).timeout;
	
	for child in get_children():
		child.visible = child == get_child(idx);
