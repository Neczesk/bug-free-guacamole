extends CanvasLayer


signal save_key_pressed
signal open_key_pressed


# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/Panel/HBoxContainer/FileButton.get_popup().connect("id_pressed", self, "on_id_pressed")
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
			emit_signal("save_key_pressed")
			$VBoxContainer/ViewWindow/View.save()
		1:
			emit_signal("open_key_pressed")
			$VBoxContainer/ViewWindow/View.open()

func on_word_count_updated(count: int):
	$VBoxContainer/Panel2/MarginContainer/WordCount.text = "Word Count: " + String(count)
