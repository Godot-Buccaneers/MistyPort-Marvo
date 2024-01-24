extends Node


func create_scene_node(scene):
	if scene is String:
		scene = load(scene)
	
	if scene is PackedScene:
		scene = scene.instantiate()
	
	return scene
