@tool
extends EditorPlugin

const TEMPLATES_SOURCE_PATH = "res://addons/camera3d_templates/script_templates/"
const TEMPLATES_DEST_PATH = "res://script_templates/Camera3D/"

func _enter_tree():
	# Create the script_templates/Camera3D directory
	if not DirAccess.dir_exists_absolute(TEMPLATES_DEST_PATH):
		DirAccess.open("res://").make_dir_recursive_absolute(TEMPLATES_DEST_PATH)
	
	# Copy template files to project's script_templates folder
	copy_template("character_first_person.gd")
	copy_template("first_person_free_floating.gd")
	
	# Refresh the file system so Godot sees the new templates
	EditorInterface.get_resource_filesystem().scan()
	
	print("Camera3D templates installed!")

func _exit_tree():
	# Remove template files
	remove_template("character_first_person.gd")
	remove_template("first_person_free_floating.gd")
	
	EditorInterface.get_resource_filesystem().scan()
	print("Camera3D templates removed!")

func copy_template(filename: String):
	var source_path = TEMPLATES_SOURCE_PATH + filename
	var dest_path = TEMPLATES_DEST_PATH + filename
	
	var source = FileAccess.open(source_path, FileAccess.READ)
	if source:
		var content = source.get_as_text()
		source.close()
		
		var dest = FileAccess.open(dest_path, FileAccess.WRITE)
		if dest:
			dest.store_string(content)
			dest.close()
			print("Copied: ", filename)

func remove_template(filename: String):
	var file_path = TEMPLATES_DEST_PATH + filename
	if FileAccess.file_exists(file_path):
		DirAccess.open("res://").remove_absolute(file_path)
		print("Removed: ", filename)
