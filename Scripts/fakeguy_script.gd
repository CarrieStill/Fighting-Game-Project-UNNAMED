extends CharacterBody2D

@export var speed: int = 300
@export var acceleration: int = 70
@export var gravity: int = speed * 5
@export var down_gravity_factor: float = 3
@export var jump_speed: int = -350 * 3
@export var playerInputs: Array = ["upP1", "downP1", "leftP1", "rightP1"]
@export var health: int = 1000
@export var characterName = "Fake Guy"


@onready var jump_buffer_timer: Timer = $JumpBufferTimer
@onready var testguyAnimations = $AnimatedSprite2D
@onready var Hitbox: Area2D = $Hitbox
@onready var myCharacter: CharacterBody2D = self
@onready var theirCharacter: CharacterBody2D = self
enum State{IDLE, WALK, JUMP, DOWN, ATTACK, BLOCK, RECOVERY, STARTUP, LEFT, RIGHT}

var current_state: State = State.IDLE
var facing_state: State = State.RIGHT
var jumpDirection = 0
func init(myChar: CharacterBody2D, theirChar: CharacterBody2D) -> void:
	myCharacter = myChar
	theirCharacter = theirChar

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
		velocity
	elif Hitbox.has_overlapping_areas():
		if facing_state == State.LEFT:
			velocity.x = speed
		else:
			velocity.x = -speed
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

func get_walk() -> void:
	if facing_state == State.RIGHT:
		if velocity.x < 0:
			testguyAnimations.play("BACKWALK")
		else:
			testguyAnimations.play("WALK")
	else:
		if velocity.x < 0:
			testguyAnimations.play("WALK")
		else:
			testguyAnimations.play("BACKWALK")
	return

func update_states() -> void:
	match current_state:
		State.IDLE when velocity.x != 0:
			current_state = State.WALK
			
			
		State.WALK:
			if velocity.x == 0:
				current_state = State.IDLE
				testguyAnimations.play("IDLE")
				if not is_on_floor() && velocity.y > 0:
					current_state = State.DOWN
			else:
				get_walk()
				
		State.JUMP when velocity.y > 0:
			current_state = State.DOWN
		
		State.DOWN when is_on_floor:
			if velocity.x == 0:
				current_state = State.IDLE
				testguyAnimations.play("IDLE")
			else:
				get_walk()
				current_state = State.WALK

#Update the direction that players are facing, keeps them facing each other.
func update_direction() -> void:
	var playerDistance = myCharacter.position.x - theirCharacter.position.x
	if playerDistance > 0:
		facing_state = State.LEFT
	else:
		facing_state = State.RIGHT
	
	if(facing_state == State.LEFT):
		testguyAnimations.flip_h = 1
	else:
		testguyAnimations.flip_h = 0
