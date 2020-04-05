extends Object

class_name Project

var file_path := ""
var scenes := {}

func ready():
	pass
	
func add_string_as_scene(scene: String, scene_id: int) -> int:
	scenes[scene_id] = scene
	save_project()
	return 0

func save_project():
	var save_file := File.new()
	save_file.open(file_path, File.WRITE)
	var json := JSON.print(scenes)
	save_file.store_string(json)
	
func open_project():
	var open_file := File.new()
	open_file.open(file_path, File.READ)
	var json := JSON.parse(open_file.get_as_text())
	if json.result is Dictionary:
		scenes = json.result.duplicate()
