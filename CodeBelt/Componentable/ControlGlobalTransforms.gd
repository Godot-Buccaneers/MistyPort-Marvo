class_name ControlGlobalTransform extends Node

@onready var parentNode:Control = get_parent():
	set(value):
		parentNode = value
		if not has_valid_parent and parentNode != null:
			printerr("ControlGlobalTransforms-Node's Parent is not a Control Node")
var transform : Transform2D :
	get:
		return parentNode.get_global_transform()

var position : Vector2 :
	get:
		return parentNode.global_position
	set(value):
		parentNode.global_position = value
var scale : Vector2 :
	get:
		return transform.get_scale()
	set(value):
		parentNode.scale = value - parentNode.scale/scale
var rotation : float :
	get:
		return transform.get_rotation()
	set(value):
		parentNode.rotation = transform.rotated_local(value/rotation).get_rotation()
var rotation_degrees : float :
	get:
		return rad_to_deg(transform.get_rotation())
	set(value):
		parentNode.rotation = transform.rotated_local(deg_to_rad(value)/rotation).get_rotation()

var has_valid_parent:bool :
	get:
		return parentNode is Control

func _init(_parent=null):
	parentNode = _parent
