extends Node2D

var speed = 80
var gameSizeX = 1024

var areaSegments = [
	preload("res://instances/areaSegments/A.tscn"),	
	preload("res://instances/areaSegments/B.tscn")
]

func _ready():
	#randomize()
	spawn_segment(0,0)
	spawn_segment(gameSizeX,0)


func _physics_process(delta):
	for area in $AreaSegments.get_children():
		area.position.x -= speed * delta
		if area.position.x < gameSizeX * (-1):
			print(area.position.x)
			spawn_segment(area.position.x + gameSizeX*2, 0)
			area.queue_free()
		
	$Player.position.x -= speed * delta
	
func spawn_segment(x,y):
	var instance = areaSegments[randi() % len(areaSegments)].instance()
	instance.position = Vector2(x,y)
	$AreaSegments.add_child(instance)
