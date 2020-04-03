extends TextureRect

func _ready():
	var save_file = File.new()
	if save_file.file_exists("saved_work.json"):
		restore_work()
		
func _process(_delta):
	if Input.is_action_pressed("save_current"):
		save_work()

func save_work():
	var save_file = File.new()
	save_file.open("saved_work.json", File.WRITE)
	save_file.store_string($Margins/Panel/MarginContainer/TextEdit.text)
	save_file.close()

func restore_work():
	var save_file = File.new()
	save_file.open("saved_work.json", File.READ)
	$Margins/Panel/MarginContainer/TextEdit.text = save_file.get_as_text()
	save_file.close()

