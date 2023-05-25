extends Label


@export var target : TextEdit;
@export var maximum : int;


func _ready() -> void:
	target.text_changed.connect(update_label);
	text = "%s/%s" % [target.text.length(), maximum];

func update_label() -> void:
	text = "%s/%s" % [target.text.length(), maximum];
