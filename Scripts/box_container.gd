extends BoxContainer

@export var selection = 0
@export var charList = ["testguy", "testguy2"]

@onready var SelectArrow: Sprite2D = $SelectArrow
func _process(delta: float) -> void:
	update_arrow()



func update_arrow() -> void:
	SelectArrow.position.x = selection
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_left"):
		selection = max(selection - 1, 0)
		return
	if event.is_action_pressed("ui_right"):
		selection = min(selection + 1, charList.size())
		return
