extends CanvasLayer

var current_project := Project.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/Panel/HBoxContainer/FileButton.get_popup().connect("id_pressed", self, "on_id_pressed")
	$FileDialog.connect("file_selected", self, "on_file_chosen")
# warning-ignore:return_value_discarded
	$VBoxContainer/ViewWindow/View.connect("word_count_updated", self, "on_word_count_updated")
	$VBoxContainer/ViewWindow/View.count_words()
	
	var save_key = InputEventKey.new()
	save_key.control = true
	save_key.scancode = KEY_S
	
	var open_key = InputEventKey.new()
	open_key.control = true
	open_key.scancode = KEY_O
	
	$VBoxContainer/Panel/HBoxContainer/FileButton.get_popup().add_item("Save", 0, save_key.get_scancode_with_modifiers())
	$VBoxContainer/Panel/HBoxContainer/FileButton.get_popup().add_item("Open", 1, open_key.get_scancode_with_modifiers())


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func on_id_pressed(id: int):
	match id:
		0:
			save_dialog_open()
		1:
			open_dialog_open()

func on_word_count_updated(count: int):
	$VBoxContainer/Panel2/MarginContainer/WordCount.text = "Word Count: " + String(count)

func save(path: String):
	current_project.file_path = path
	current_project.add_string_as_scene($VBoxContainer/ViewWindow/View.get_current_text(), 0)
	
func save_dialog_open():
	$FileDialog.mode = $FileDialog.MODE_SAVE_FILE
	$FileDialog.visible = true

func open_dialog_open():
	$FileDialog.mode = $FileDialog.MODE_OPEN_FILE
	$FileDialog.visible = true

func on_file_chosen(path: String):
	if $FileDialog.mode == $FileDialog.MODE_SAVE_FILE:
		save(path)
	elif $FileDialog.mode == $FileDialog.MODE_OPEN_FILE:
		open_project(path)
	
func open_scene(id: String) -> String:
	var current_scene_text = current_project.scenes[id]
	return current_scene_text
	
func open_project(path: String):
	current_project.file_path = path
	current_project.open_project()
	$VBoxContainer/ViewWindow/View.set_current_text(open_scene("0"))
