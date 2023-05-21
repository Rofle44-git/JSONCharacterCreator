extends PanelContainer

signal PreviousPressed;
signal NextPressed;

@export var main_focus : Control;

func _ready() -> void:
	%Previous.pressed.connect(func(): PreviousPressed.emit());
	%Next.pressed.connect(func(): NextPressed.emit());

func focus() -> void:
	main_focus.grab_focus();
