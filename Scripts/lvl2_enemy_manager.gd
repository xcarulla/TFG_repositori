extends Node3D

# Script for managing level 2 enemies:

@export var key: CharacterBody3D

func _on_GoblinKey_killed() -> void:
	key.attach_to_player()
