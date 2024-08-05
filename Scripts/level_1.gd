extends Node3D

@export var levelName: String

var star1collected: bool = false
var star2collected: bool = false
var star3collected: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	if levelName == null:
		print("ASSIGN LEVEL NAME")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func pickUpStar(nStar: String):
	GlobalVariables.addStar(levelName, nStar)
