extends KinematicBody2D

#self explanitory variables. The values have been set by testing, there is no deeper logic behind it
#the values are acceptable for testing but feel way off for a game
const ACCELERATION = 700
const MAX_SPEED = 150
const FRICTION = 0.25
const GRAVITY = 400
const JUMP_FORCE = 300

var hearts = 3

var motion = Vector2.ZERO

#Sprite and AnimationPlayer are Nodes belonging to the Player. Since the player is an instance (Player.tscn)
#you wont be able to see or access them through the SceneViewer. Open Player.tscn in a new Scene to access them.
onready var sprite = $Sprite
onready var animationPlayer = $AnimationPlayer

#only basics. Moving, jumping, animations
func _physics_process(delta):
	var x_input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left") 
		
	if x_input != 0:
		animationPlayer.play("Run")
		motion.x += x_input * ACCELERATION * delta
		motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)	
		sprite.flip_h = x_input < 0
	else:
		animationPlayer.play("Stand")
		motion.x = lerp(motion.x, 0, FRICTION)
	
	motion.y += GRAVITY * delta
	
	#this prevents the player from "sticking" to the ceiling
	if is_on_ceiling() && motion.y < -50:
		motion.y = -50
	
	if is_on_floor():
		if x_input == 0:
			motion.x = lerp(motion.x, 0, FRICTION)
		
		if Input.is_action_just_pressed("ui_up"):
			motion.y = -JUMP_FORCE
	else:
		animationPlayer.play("Jump")
		if x_input == 0:
			motion.x = lerp(motion.x, 0, 0.02)
	
	move_and_slide(motion, Vector2.UP)

func remove_hp(var amount):
	hearts -= amount
	var filledHeartsTexture : TextureRect = get_node("/root/Game/Overlays/Hearts/filledHearts")
	print("lost heart, remaining: " + str(hearts)) #just a neet debug message. delete if not needed

	if(hearts <= 0):
		on_death()
	else:
		#the filledHeartTexture contains a .png with a 16x16 Heart icon. The texture is set to Stretch-Mode: Tile
		#this means we will see 1 additional filled Heart for every 16 pixel the texture is wider.
		#reducing the width reduces the amount of filled hearts we see. The background contains 3 empty hearts btw.
		filledHeartsTexture.set_size(Vector2(16*hearts,16))
		filledHeartsTexture.visible = true

func on_death():
	#the filledHeartsTexture cannot be less than 1 pixel wide. On death we disable the visibility to see 0 pixels of it.
	var filledHeartsTexture : TextureRect = get_node("/root/Game/Overlays/Hearts/filledHearts")
	filledHeartsTexture.visible = false
	
	#enable fog that obfuscates the game, show a GameOver! label and show a button that lets the player proceed
	var gameOverOverlay = get_node("/root/Game/Overlays/GameOver")
	gameOverOverlay.visible = true
	
	Engine.time_scale = 0.2
	

#this is a signal from Game/Borders/TeleportZone. it damages the player and moves him back into the game
func _on_TeleportZone_body_entered(body):
	if(body.name == "Player"):
		remove_hp(1)
		if(hearts > 0):
			position.y = 0
			motion.y = 0

#a crude way to restart the game. later this should be accomplished by changing scenes. For testing this is fine though.
func _restart_game():
	hearts = 3
	remove_hp(0)
	position.y = 0
	motion.y = 0
	
	var gameOverOverlay = get_node("/root/Game/Overlays/GameOver")
	gameOverOverlay.visible = false
	
	Engine.time_scale = 1

#signal from Game/Overlays/GameOver/RestartButton
func _on_Button_pressed():
	_restart_game()
