extends Node

var characterP1: PackedScene 
var characterP2: PackedScene

var PlayerScene

func loadCharacter(choice: String) -> PackedScene:
	match choice:
		"testguy":
			return preload("res://Scenes/testguyScene.tscn")
		"fakeguy":
			return preload("res://Scenes/fakeguyScene.tscn")
			#characterP2 = preload("res://Scenes/testguyScene.tscn")
	return preload("res://Scenes/testguyScene.tscn")
func loadCharacter1(choice: String) -> void:
	characterP1 = loadCharacter(choice)
	
func loadCharacter2(choice: String) -> void:
	characterP2 = loadCharacter(choice)
