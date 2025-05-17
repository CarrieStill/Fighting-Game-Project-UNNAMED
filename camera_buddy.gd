extends CharacterBody2D
@export var targetPos = 0
@export var toTarget = 0
@export var cameraSpeed = 40
@onready var Player1 = get_node("%Player1")
@onready var Player2 = get_node("%Player2")


func _physics_process(delta):
	update_movement(delta)
	move_and_slide()
	
func update_movement(_delta: float) -> void:
	targetPos = (Player1.position.x + Player2.position.x)/2
	toTarget = targetPos - position.x
	velocity.x = clampf(toTarget * cameraSpeed,-400, 400)
