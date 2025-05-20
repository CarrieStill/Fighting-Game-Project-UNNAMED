extends Node

var characterP1: PackedScene 
var characterP2: PackedScene

var PlayerScene

func loadCharacter(choice: String) -> void:
	match choice:
		"testguy":
			characterP1 = preload("res://Scenes/testguyScene.tscn")
			characterP2 = preload("res://Scenes/testguyScene.tscn")
	
