class_name FakeDelta extends Node


static var delta:float :
	get:
		return 1.0 / Engine.get_frames_per_second()
