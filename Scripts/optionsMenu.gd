extends Control

@export var anim_player: AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(delta):
	pass

func _return():
	anim_player.play("hideOptions")
