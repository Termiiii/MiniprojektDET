extends Node2D

var speed = 80
var gameSizeX = 1024

var areaSegments = [
	preload("res://instances/areaSegments/A.tscn"),	
	preload("res://instances/areaSegments/B.tscn")
]

func _ready():
	 #the engine is very deterministic. This randomizes the seed and therefore how each level will be built
	randomize()
	spawn_segment(0,0)
	spawn_segment(gameSizeX,0)


func _physics_process(delta):
	for area in $AreaSegments.get_children():
		area.position.x -= speed * delta
		#if area is outside our default camera
		if area.position.x < gameSizeX * (-1):
			spawn_segment(area.position.x + gameSizeX*2, 0) #spawn new segment that we will soon see
			area.queue_free() #remove current area
		
	#moving the player backwards, the same way we move everything backwards, gives the illusion of the camera moving forwards
	$Player.position.x -= speed * delta
	
func spawn_segment(x,y):
	#chooses a random segment from areaSegments
	var instance = areaSegments[randi() % len(areaSegments)].instance()
	instance.position = Vector2(x,y) #sets the position of the segment
	$AreaSegments.add_child(instance) #spawns it into the game
