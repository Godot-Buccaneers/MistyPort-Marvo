extends Control

var visiblePos = Vector2(2,354)
var hiddenPos = Vector2(2,291)

var isVisible = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if event is InputEventMouseButton:
		await get_tree().physics_frame
		isVisible = get_parent().get_parent().isValid

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if isVisible:
		position = position.lerp(visiblePos,delta*2)
		visible = true
	else:
		position = position.lerp(hiddenPos,delta*2)
		if (position.lerp(hiddenPos,delta)-position).length() < .1:
			visible = false
