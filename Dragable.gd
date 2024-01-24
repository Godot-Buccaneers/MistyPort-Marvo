class_name Draggable extends Control

@onready var clickInfo:ClickInfo = $ClickInfo

var isMouseInGUI:bool = false :
	set(value):
		isMouseInGUI = value

var startingPoint = Vector2.ZERO

func _ready():
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	clickInfo.click_started.connect(_on_click_start)
	clickInfo.click_stopped.connect(_on_click_stopped)

func _physics_process(delta):
	if clickInfo.is_dragging and $"..".isDragged:
		get_parent().global_position = get_parent().global_position.lerp(startingPoint + clickInfo.draggedVect,delta*3)

func _on_click_start():
	$"..".isDragged = isMouseInGUI
	startingPoint = get_parent().global_position

func _on_click_stopped():
	if $"..".isDragged:
		while get_parent().global_position.distance_to(startingPoint + clickInfo.draggedVect) > 1:
			await get_tree().physics_frame
			get_parent().global_position = get_parent().global_position.lerp(startingPoint + clickInfo.draggedVect,FakeDelta.delta*3)

func _on_mouse_entered():
	isMouseInGUI = true

func _on_mouse_exited():
	isMouseInGUI = false
	
