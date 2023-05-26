extends Control


@onready var tree_root : TreeItem = %Folders.create_item();

var get_from : String = "";
var load_lock : bool = false;


func _ready() -> void:
	tree_root.set_text(0, "Folders");
	tree_root.disable_folding = true;
	
	var i : TreeItem;
	for folder in DirAccess.get_directories_at(Global.characters_location):
		if folder.begins_with("_"):
			i = %Folders.create_item(tree_root);
			i.set_text(0, folder);

func _on_load_pressed() -> void:
	%Load.disabled = true;
	%Load.text = "...";
	await get_tree().process_frame;
	
	# Clearing
	for file in DirAccess.get_files_at(Global.characters_location):
		DirAccess.remove_absolute(Global.characters_location.path_join(file));
	
	# Copying
	for file in DirAccess.get_files_at(Global.characters_location.path_join(get_from)):
		DirAccess.copy_absolute(Global.characters_location.path_join(get_from).path_join(file), Global.characters_location.path_join(file));

	%Load.text = "Load";
	%Load.disabled = false;

func _on_folders_item_selected() -> void:
	get_from = %Folders.get_selected().get_text(0);
	%Load.disabled = false;
