extends Area2D

var targetPoint = Vector2(0,0)
@onready var colisionShape:CollisionShape2D = $CollisionShape2D

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	
	get_parent().position = get_parent().position.lerp(targetPoint,delta*3)
	
	var a = get_parent().get_parent().get_parent().get_children().duplicate() ; a.reverse()
	for child in a:
		if child != get_parent().get_parent() and child is BingoBoard:
			if child.get_child(0).get_child(0).colisionShape.shape.get_rect().has_point(child.get_child(0).get_child(0).get_local_mouse_position()):
				targetPoint = Vector2(-250,0)
				return
		else:
			break
	
	if colisionShape.shape.get_rect().has_point(get_local_mouse_position()):
		
		
		
		targetPoint = Vector2(-250,-457)
		var b = get_parent().get_parent().get_parent().get_children().duplicate() ; b.reverse()
		for child in b:
			if child != get_parent().get_parent() and child is BingoBoard:
				child.get_child(0).get_child(0).targetPoint = Vector2(-250,0)
			else:
				break
	else:
		targetPoint = Vector2(-250,-357)
