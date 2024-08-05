extends Node3D

var collected: bool = false
@onready var anim_player: AnimationPlayer = $AnimationPlayer
var level

func _ready():
	level = get_parent()

func getCollected(_area): # Area3D signal trigger function
	if(!collected):
		collected = true
		anim_player.play("Collect Star")
		level.pickUpStar(name)


func selfDelete():
	self.queue_free()
