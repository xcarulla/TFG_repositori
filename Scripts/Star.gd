extends Node3D

var collected: bool = false
@onready var anim_player: AnimationPlayer = $AnimationPlayer


func getCollected(_area): # Area3D signal trigger function
	if(!collected):
		collected = true
		anim_player.play("Collect Star")
		# Falta avisar al nivell que ha conseguit una estrella


func selfDelete():
	self.queue_free()
