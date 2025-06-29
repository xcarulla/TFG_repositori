extends Node3D

# Script for managing level 1 enemies:

@export var key: CharacterBody3D

func _on_enemy_1_tree_exiting() -> void:
	key.attach_to_player()
