extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $PlayerAnimation
@onready var frontRay: RayCast2D = $FrontRay


@export var item_infront = null
@export var speed=100
var input_direction

func _ready() -> void:
	frontRay.target_position = Vector2(0.0, 20.0)

func _physics_process(delta):
	get_input()
	move_and_slide()
	player_animation()
	player_idle()
	player_interact()

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
	if frontRay.is_colliding():
		var detect = frontRay.get_collider()
		if detect is Area2D:
			var item_current_inFront = detect.name
			if item_infront != item_current_inFront:
				item_infront = detect.name
				print("Item : ", item_infront)
		if Input.is_action_just_pressed("Interact"):
			print("I just clicked: ", item_infront)
	else:
		if item_infront != null:
			print("null")
			item_infront = null
		
	
