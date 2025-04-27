extends CharacterBody2D

@export var speed = 400

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	var gravity = Vector2(0,50)
	velocity = (input_direction * speed) + gravity
	
func _physics_process(delta):
	get_input()
	move_and_slide()
