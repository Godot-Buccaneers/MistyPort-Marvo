class_name ClickInfo extends Node

var clickedPoint:Vector2 = Vector2.ZERO
var draggedPoint:Vector2 = Vector2.ZERO
var draggedVect:Vector2 : 
	get:
		return clickedPoint.direction_to(draggedPoint) * clickedPoint.distance_to(draggedPoint)

var drag_tolerance = 10.0
var clickTrigger = MOUSE_BUTTON_LEFT

signal click_started
signal click_stopped
var is_clicked:bool :
	get:
		var previousValue = is_clicked
		is_clicked = Input.is_mouse_button_pressed(clickTrigger)
		if is_clicked != previousValue:
			if is_clicked: click_started.emit() ; _on_click_started()
			else: click_stopped.emit() ; _on_click_stopped()
		return is_clicked

signal drag_started
signal drag_stopped
var is_dragging:bool :
	get:
		var previousValue = is_dragging
		is_dragging = is_clicked and clickedPoint.distance_to(draggedPoint) > drag_tolerance
		if is_dragging != previousValue:
			if is_dragging: drag_started.emit() ; _on_drag_started()
			else: drag_stopped.emit() ; _on_drag_stopped()
		return is_dragging

func _init(_clickTrigger = MOUSE_BUTTON_LEFT):
	clickTrigger = _clickTrigger

func _input(event):
	
	if event is InputEventScreenTouch: # Updates the Clicked Point
		if event.pressed:
			clickedPoint = event.position
			draggedPoint = clickedPoint
	elif event is InputEventMouseButton:
		if event.button_index == clickTrigger and event.pressed:
			clickedPoint = event.global_position
			draggedPoint = clickedPoint
	
	if event is InputEventScreenDrag: # Updates the Dragged Point
		draggedPoint = event.position
	elif event is InputEventMouseMotion:
		if Input.is_mouse_button_pressed(clickTrigger):
			draggedPoint = event.global_position
	
	is_dragging # Triggers Click & Drag Related Signals

func _on_click_started():
	pass
func _on_click_stopped():
	pass
func _on_drag_started():
	pass
func _on_drag_stopped():
	pass
