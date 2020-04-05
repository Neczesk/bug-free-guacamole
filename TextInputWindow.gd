extends TextureRect

signal word_count_updated

var word_count := 0

func _ready():
	pass
		
func _process(_delta):
	if Input.is_action_just_released("new_paragraph"):
		new_paragraph()
	if Input.is_action_just_released("print_cursor"):
		print_cursor_location()

func _on_TextEdit_text_changed():
	update_word_count()
	
func update_word_count():
	var processed_string = $Margins/Panel/MarginContainer/TextEdit.text
	if processed_string is String:
		processed_string = processed_string.strip_edges(false, true)
		processed_string = processed_string.replace("/n", " ")
	var words = processed_string.split(" ")
	for idx in range(words.size()):
		if idx < words.size():
			if words[idx] == " " or words[idx] == "":
				words.remove(idx)
	if words is PoolStringArray:
		word_count = words.size()
		emit_signal("word_count_updated", word_count)
		
func new_paragraph():
	$Margins/Panel/MarginContainer/TextEdit.insert_text_at_cursor("\n")
	
func print_cursor_location():
	print("line: " + String($Margins/Panel/MarginContainer/TextEdit.cursor_get_line()))
	print("column: " + String($Margins/Panel/MarginContainer/TextEdit.cursor_get_column()))
	
func get_current_text() -> String:
	return $Margins/Panel/MarginContainer/TextEdit.text

func set_text(text: String):
	$Margins/Panel/MarginContainer/TextEdit.text = text
