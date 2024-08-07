extends Control

@export var anim_player: AnimationPlayer

func _return():
	anim_player.play("hideOptions")
