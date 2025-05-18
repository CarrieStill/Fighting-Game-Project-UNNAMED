extends Node2D

 #needs to handle fight systems
@onready var Player1: CharacterBody2D = $Player1
@onready var Player2: CharacterBody2D = $Player2


@onready var CameraBuddy: CharacterBody2D = $CameraBuddy
@onready var HealthBarP1: ProgressBar = $CameraBuddy/HealthBarP1
@onready var HealthBarP2: ProgressBar = $CameraBuddy/HealthBarP2

func _ready() -> void:
	HealthBarP1.max_value = Player1.health
	HealthBarP2.max_value = Player2.health
	
	
func _physics_process(delta: float) -> void:
	Player1
	
func _process(delta: float) -> void:
	updateHealth(HealthBarP1, Player1)
	updateHealth(HealthBarP2, Player2)
#Health
func updateHealth(healthBar: ProgressBar, player: CharacterBody2D) -> void:
	var healthDiff = abs(player.health - healthBar.value) / 10
	#healthBar.value = player.health
	healthBar.value = move_toward(healthBar.value, player.health, healthDiff)

#Time



#
