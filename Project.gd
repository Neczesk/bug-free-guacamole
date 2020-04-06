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
	
func create_scene(scene_name: String, scene_path: String, scene_text: String):
	var new_scene := scene.new()
	new_scene.scene_name = scene_name
	new_scene.scene_path = scene_path
	var levels := scene_path.split("/")
	if levels.size() > 1:
		scenes[levels[0]].add_child_scene(new_scene)
	else:
		scenes[levels[0]] = new_scene

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

class scene:
	var scene_name := ""
	var scene_path := ""
	var scene_text := ""
	var scene_children := {}
