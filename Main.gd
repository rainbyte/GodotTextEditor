extends Control

var app_name : String = "Text Editor"
var current_file : String = "Untitled"

func _ready():
	self.update_window_title()
	
	$MenuButtonFile.get_popup().add_item("New file")
	$MenuButtonFile.get_popup().add_item("Open file...")
	$MenuButtonFile.get_popup().add_item("Save file")
	$MenuButtonFile.get_popup().add_item("Save file as...")
	$MenuButtonFile.get_popup().add_item("Quit")
	$MenuButtonFile.get_popup().connect("id_pressed", self, "_on_item_file_pressed")
	
	$MenuButtonHelp.get_popup().add_item("About")
	$MenuButtonHelp.get_popup().add_item("Godot webpage")
	$MenuButtonHelp.get_popup().connect("id_pressed", self, "_on_item_help_pressed")


func update_window_title():
	OS.set_window_title(app_name + " - " + current_file)


func new_file():
	current_file = "Untitled"
	update_window_title()
	$TextEdit.text = ""


func save_file():
	var path : = current_file
	if path == "Untitled":
		$SaveDialog.popup()
	else:
		var f : = File.new()
		f.open(path, File.WRITE)
		f.store_string($TextEdit.text)
		f.close()
		current_file = path
		update_window_title()


func _on_OpenDialog_file_selected(path : String):
	var f : = File.new()
	f.open(path, File.READ)
	$TextEdit.text = f.get_as_text()
	f.close()
	current_file = path
	update_window_title()


func _on_SaveDialog_file_selected(path : String):
	var f : = File.new()
	f.open(path, File.WRITE)
	f.store_string($TextEdit.text)
	f.close()
	current_file = path
	update_window_title()


func _on_item_file_pressed(id):
	var item_name : String = $MenuButtonFile.get_popup().get_item_text(id)
	if item_name == "New file":
		new_file()
	elif item_name == "Open file...":
		$OpenDialog.popup()
	elif item_name == "Save file":
		save_file()
	elif item_name == "Save file as...":
		$SaveDialog.popup()
	elif item_name == "Quit":
		var foo : SceneTree = get_tree()
		foo.quit()


func _on_item_help_pressed(id):
	var item_name : String = $MenuButtonHelp.get_popup().get_item_text(id)
	if item_name == "About":
		$AboutDialog.popup()
	elif item_name == "Godot webpage":
		OS.shell_open("https://godotengine.org")
