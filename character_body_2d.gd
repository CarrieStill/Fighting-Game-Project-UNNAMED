extends CharacterBody2D

@export var speed: int = 400
@export var acceleration: int = 35
@export var gravity: int = speed * 5
@export var down_gravity_factor: float = 3
@export var jump_speed: int = -speed * 2
@export var playerInputs: Array = ["upP1", "downP1", "leftP1", "rightP1"]

@onready var jump_buffer_timer: Timer = $JumpBufferTimer
@onready var coyote_timer: Timer = $CoyoteTimer

enum State{IDLE, WALK, JUMP, DOWN}
var current_state: State = State.IDLE

func _physics_process(delta):
	get_input()
	update_movement(delta)
	update_states()
	move_and_slide()
	
	
func get_input():
	if(name == "Player2"):
		playerInputs = ["upP2", "downP2", "leftP2", "rightP2"]
		
	if (Input.is_action_just_pressed(playerInputs[0])):
		jump_buffer_timer.start()

	var direction = Input.get_axis(playerInputs[2], playerInputs[3])
	if direction == 0:
		velocity.x = move_toward(velocity.x, 0, acceleration)
	else:
		velocity.x = move_toward(velocity.x, speed*direction, acceleration)
	
func update_movement(delta: float) -> void:
	if (is_on_floor() || coyote_timer.time_left >0) && jump_buffer_timer.time_left > 0:
		velocity.y = jump_speed
		current_state = State.JUMP
		jump_buffer_timer.stop()
		coyote_timer.stop()
		
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
					coyote_timer.start()
		State.JUMP when velocity.y > 0:
			current_state = State.DOWN
		
		State.DOWN when is_on_floor:
			if velocity.x == 0:
				current_state = State.IDLE
			else:
				current_state = State.WALK
