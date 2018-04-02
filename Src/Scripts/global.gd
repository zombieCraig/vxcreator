extends Node

const VX_VERSION = "0.0.6"

var resource_queue = null # ResourceLoader Queue
var current_scene = null

var prefs = {
		"Fullscreen": false,
		"Sound": true,
		"ShowWelcomeMsg": true}

func _ready():
	resource_queue = preload("res://Scripts/resource_queue.gd").new()
	resource_queue.start()
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)


# Switches to a new scene from the resource_queue if available, else load from disk
func goto_scene(scene):
	current_scene.queue_free()
	if resource_queue.is_ready(scene):
		current_scene = resource_queue.get_resource(scene).instance()
	else:
		current_scene = ResourceLoader.load(scene).instance()
	get_tree().get_root().add_child(current_scene)
