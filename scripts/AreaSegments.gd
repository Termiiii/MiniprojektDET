extends Node2D

var speed = 200

#moving all game elements backward gives the illusion that the camera is moving forward
func _physics_process(delta):
	for area in get_children():
		area.position.x -= speed * delta


