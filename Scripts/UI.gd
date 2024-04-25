extends Control

@export var dummy: CharacterBody3D
var grounded
var attacking
var attackType

func _ready():
	grounded = $AnimationStates/GridContainer/grounded
	attacking = $AnimationStates/GridContainer/attacking
	attackType = $AnimationStates/GridContainer/attackType

func _process(_delta):
	grounded.text = dummy._returnTransitionState("grounded")
	attacking.text = dummy._returnTransitionState("attacking")
	attackType.text = dummy._returnTransitionState("attacks")
