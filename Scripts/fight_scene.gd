extends Node2D

 #needs to handle fight systems
@export var Player1 = Global.characterP1.instantiate()
@export var Player2 = Global.characterP2.instantiate()

@onready var CameraBuddy: CharacterBody2D = $CameraBuddy
@onready var HealthBarP1: ProgressBar = $CameraBuddy/HealthBarP1
@onready var HealthBarP2: ProgressBar = $CameraBuddy/HealthBarP2

func _ready() -> void:
	add_child(Player1)
	add_child(Player2)
	Player1.name = "Player1"
	Player2.name = "Player2"
	Player1.init(Player1, Player2)
	Player2.init(Player2, Player1)
	Player1.position.x = 840
	Player1.position.y = -111
	Player2.position.x = 1330
	Player2.position.y = -111
	CameraBuddy.set_players(Player1, Player2)
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
