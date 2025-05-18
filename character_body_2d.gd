extends CharacterBody2D

@export var speed: int = 400
@export var acceleration: int = 70
@export var gravity: int = speed * 5
@export var down_gravity_factor: float = 3
@export var jump_speed: int = -speed * 3
@export var playerInputs: Array = ["upP1", "downP1", "leftP1", "rightP1"]
@export var health: int = 1000


@onready var jump_buffer_timer: Timer = $JumpBufferTimer
@onready var testguyAnimations = $AnimatedSprite2D
@onready var Player1: CharacterBody2D = $%Player1
@onready var Player2: CharacterBody2D = $%Player2
enum State{IDLE, WALK, JUMP, DOWN, ATTACK, BLOCK, RECOVERY, STARTUP, LEFT, RIGHT}

var current_state: State = State.IDLE
var facing_state: State = State.RIGHT
var jumpDirection = 0

func _physics_process(delta):
	get_input()
	update_direction()
	update_movement(delta)
	update_states()
	move_and_slide()
	
	
func get_input():
	if(name == "Player2"):
		playerInputs = ["upP2", "downP2", "leftP2", "rightP2"]
		
	if (Input.is_action_just_pressed(playerInputs[0])):
		
		if(Input.is_action_pressed(playerInputs[2])):
			jumpDirection = -1
		elif(Input.is_action_pressed(playerInputs[3])):
			jumpDirection = 1
		else:
			jumpDirection = 0
		health -= 100
		jump_buffer_timer.start()

	var direction = Input.get_axis(playerInputs[2], playerInputs[3])
	#Horizontal Movement Control
	if !is_on_floor():
		#do nothing
		velocity.x
	elif direction == 0:
		velocity.x = move_toward(velocity.x, 0, acceleration)
	else:
		velocity.x = move_toward(velocity.x, speed*direction, acceleration)
	
func update_movement(delta: float) -> void:
	if (is_on_floor()) && jump_buffer_timer.time_left > 0:
		velocity.y = jump_speed
		velocity.x = speed * jumpDirection
		current_state = State.JUMP
		jump_buffer_timer.stop()
		
	if current_state == State.JUMP:
		velocity.y += gravity * delta
	else:
		velocity.y += gravity * delta * down_gravity_factor
	
func update_states() -> void:
	match current_state:
		State.IDLE when velocity.x != 0:
			current_state = State.WALK
			
		State.WALK:
			if velocity.x == 0:
				current_state = State.IDLE
				if not is_on_floor() && velocity.y > 0:
					current_state = State.DOWN
		State.JUMP when velocity.y > 0:
			current_state = State.DOWN
		
		State.DOWN when is_on_floor:
			if velocity.x == 0:
				current_state = State.IDLE
			else:
				current_state = State.WALK

#Update the direction that players are facing, keeps them facing each other.
func update_direction() -> void:
	var playerDistance = Player1.position.x - Player2.position.x
	var directionP1 = 0
	var directionP2 = 1
	if playerDistance > 0:
		directionP1 = 1
		directionP2 = 0
	
	if(name == "Player1"):
		testguyAnimations.flip_h = directionP1
	elif(name == "Player2"):
		testguyAnimations.flip_h = directionP2
