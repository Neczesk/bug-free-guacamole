extends TextureRect

signal word_count_updated

var word_count := 0

func _ready():
	var save_file = File.new()
	if save_file.file_exists("saved_work.json"):
		restore_work()
		
func _process(_delta):
	if Input.is_action_just_released("new_paragraph"):
		new_paragraph()
	if Input.is_action_just_released("print_cursor"):
		print_cursor_location()


func save_work(path: String):
	var save_file = File.new()
	save_file.open(path, File.WRITE)
	save_file.store_string($Margins/Panel/MarginContainer/TextEdit.text)
	save_file.close()
	
func open_file(path: String):
	var open_file = File.new()
	open_file.open(path, File.READ)
	$Margins/Panel/MarginContainer/TextEdit.text = open_file.get_as_text()
	open_file.close()
	
func save_action_pressed():
	$FileDialog.mode = FileDialog.MODE_SAVE_FILE
	$FileDialog.current_dir = "user://"
	$FileDialog.visible = true

func open_action_pressed():
	$FileDialog.mode = FileDialog.MODE_OPEN_FILE
	$FileDialog.current_dir = "user://"
	$FileDialog.visible = true

func restore_work():
	var save_file = File.new()
	save_file.open("saved_work.json", File.READ)
	$Margins/Panel/MarginContainer/TextEdit.text = save_file.get_as_text()
	save_file.close()


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


func _on_FileDialog_file_selected(path: String):
	if $FileDialog.mode == FileDialog.MODE_SAVE_FILE:
		save_work(path)
	elif $FileDialog.mode == FileDialog.MODE_OPEN_FILE:
		open_file(path)
		

