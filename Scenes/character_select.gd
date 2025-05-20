extends Node2D

@export var selection = 0
@export var charList = ["testguy", "testguy"]
@export var ArrowLoc = [-369, -120]
@onready var SelectArrow: Sprite2D = $SelectArrow

func _process(delta: float) -> void:
	update_arrow()



func update_arrow() -> void:
	SelectArrow.position.x = ArrowLoc[selection]
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_left"):
		selection = max(selection - 1, 0)
		return
	if event.is_action_pressed("ui_right"):
		selection = min(selection + 1, charList.size()-1)
		return
	if event.is_action_pressed("ui_select"):
		Global.loadCharacter(charList[selection])
		get_tree().change_scene_to_file("res://Scenes/Fight_Scene.tscn")
		return
