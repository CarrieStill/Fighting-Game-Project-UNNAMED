extends Node2D

@onready var playButton: TextureButton = $TextureButton

#func _process(delta: float) -> void:
	#if playButton.button_pressed:
		


func _on_texture_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Fight_Scene.tscn")
