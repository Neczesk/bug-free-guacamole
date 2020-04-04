extends ColorRect

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal word_count_updated

# Called when the node enters the scene tree for the first time.
func _ready():
# warning-ignore:return_value_discarded
	$MarginContainer/HBoxContainer/TextInputWindow.connect("word_count_updated", self, "on_word_count_updated") # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func save():
	$MarginContainer/HBoxContainer/TextInputWindow.save_action_pressed()

func open():
	$MarginContainer/HBoxContainer/TextInputWindow.open_action_pressed()


func on_word_count_updated(count: int):
	emit_signal("word_count_updated", count)
	
func count_words():
	$MarginContainer/HBoxContainer/TextInputWindow.update_word_count()


func _on_OutsideView_finished():
	$MarginContainer/HBoxContainer/VBoxContainer/WindowEffects/WindowFrame/MarginContainer/OutsideView.play() # Replace with function body.
