extends Window


func _ready() -> void:
	%YourName.grab_focus();
	var c : ConfigFile = ConfigFile.new();
	c.load(Global.CONFIG_PATH);
	%YourName.text = c.get_value("User", "YourName", "You");
	%YourName.placeholder_text = %YourName.text;
	c.save(Global.CONFIG_PATH);

func _on_cancel_pressed() -> void:
	queue_free();

func _on_apply_pressed() -> void:
	var c : ConfigFile = ConfigFile.new();
	c.load(Global.CONFIG_PATH);
	c.set_value("User", "YourName", %YourName.text);
	c.save(Global.CONFIG_PATH);
	_on_cancel_pressed();
