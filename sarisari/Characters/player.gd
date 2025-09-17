extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $PlayerAnimation

@export var speed=200
var input_direction


func _physics_process(delta):
	get_input()
	move_and_slide()
	player_animation()
	player_idle()

func get_input():
	input_direction = Input.get_vector("MoveLeft","MoveRight","MoveUp","MoveDown")
	velocity = input_direction*speed
	
func player_animation():
	if Input.is_action_pressed("MoveRight"):
		anim.flip_h = false
		anim.play("PlayerWalkSide")
	elif Input.is_action_pressed("MoveLeft"):
		anim.flip_h = true
		anim.play("PlayerWalkSide")
	elif Input.is_action_pressed("MoveDown"):
		anim.play("PlayerWalkDown")
	elif Input.is_action_pressed("MoveUp"):
		anim.play("PlayerWalkUp")
		
func player_idle():
	if Input.is_action_just_released("MoveLeft"):
		anim.flip_h = true
		anim.play("PlayerIdleSide")
	elif Input.is_action_just_released("MoveRight"):
		anim.flip_h = false
		anim.play("PlayerIdleSide")
	elif Input.is_action_just_released("MoveDown"):
		anim.play("PlayerIdleDown")
	elif Input.is_action_just_released("MoveUp"):
		anim.play("PlayerIdleUp")
		
func player_interact():
	if Input.is_action_pressed("Interact"):
		print("Interacted")
	
