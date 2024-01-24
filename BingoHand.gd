@tool
extends Node2D




func _physics_process(delta):
	tween_bingos(delta*5)

func tween_bingos(time:float):
	for childID in get_child_count():
		#if not get_child(-childID).isDragged:
			if childID in range(3):
				get_child(-childID).rotation_degrees = lerp(get_child(-childID).rotation_degrees,lerp(0.0,360.0,(childID+0.0)/3)/7-(360/3)+102.5,time)
				get_child(-childID).position = get_child(-childID).position.lerp((Vector2.from_angle(get_child(-childID).rotation)*100).rotated(deg_to_rad(-90))*Vector2(9,8),time)
			else:
				get_child(-childID).rotation_degrees = lerp(get_child(-childID).rotation_degrees,lerp(0.0,360.0,(childID+0.0)/get_child_count())-(360/get_child_count()),time)
				get_child(-childID).position = get_child(-childID).position.lerp((Vector2.from_angle(get_child(-childID).rotation)*100).rotated(deg_to_rad(-90))*Vector2(1,1),time*.8)

func _on_left_pressed():
	move_child(get_child(-1),0)
	get_child(1).rotation_degrees = get_child(0).rotation_degrees + 360

func _on_right_pressed():
	move_child(get_child(0),-1)
	get_child(0).rotation_degrees = get_child(0).rotation_degrees - 360
