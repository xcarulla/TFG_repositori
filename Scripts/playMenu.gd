extends Control

@export var anim_player: AnimationPlayer

func _return():
	anim_player.play("hidePlay")

func _playLevel(): # s'ha de fer inteligent per varis nivells
	get_tree().change_scene_to_file("res://Scenes/level_1.tscn")
