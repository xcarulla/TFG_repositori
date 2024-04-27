extends Control

@export var anim_player: AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	anim_player.play("title_anim")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _play():
	get_tree().change_scene_to_file("res://Scenes/level_1.tscn")
	
func _quit():
	get_tree().quit()

