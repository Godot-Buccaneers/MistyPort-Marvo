class_name MouseInArea extends Node

@onready var parentNode:Node = get_parent()

var mouseInArea:bool = false

var mouseInRect:bool : # Needs Fixed
	get:
		if parentNode is Control:
			return parentNode.get_rect().has_point((-(parentNode.get_global_mouse_position()-parentNode.global_position)+Vector2.RIGHT*parentNode.get_rect().size.x*.4)/parentNode.get_global_transform().get_scale())
		elif parentNode is Area2D:
			if parentNode.find_child("CollisionShape2D") != null:
				if parentNode.find_child("CollisionShape2D").shape != null:
					return parentNode.find_child("CollisionShape2D").shape.get_rect().has_point(parentNode.find_child("CollisionShape2D").get_local_mouse_position())
				else:
					printerr("MouseInArea-Node parent's CollisionShape2D child lacks a shape component")
			else:
				printerr("MouseInArea-Node cant find parent's CollisionShape2D child")
	
		return false
var has_valid_parent:bool :
	get:
		return get_parent().has_signal("mouse_entered") and get_parent().has_signal("mouse_exited")

func _ready():
	if has_valid_parent:
		parentNode.mouse_entered.connect(_mouse_entered)
		parentNode.mouse_exited.connect(_mouse_exited)
	else:
		printerr("MouseInArea-Node's Parent Lacks the mouse_entered and mouse_exited signals")

func _mouse_entered():
	mouseInArea = true
func _mouse_exited():
	mouseInArea = false
