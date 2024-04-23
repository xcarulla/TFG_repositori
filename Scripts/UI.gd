extends Control

@export var dummy: CharacterBody3D
var grounded
var attacking

func _ready():
	grounded = $AnimationStates/GridContainer/grounded
	attacking = $AnimationStates/GridContainer/attacking

func _process(delta):
	grounded.text = dummy._returnTransitionState("grounded")
	attacking.text = dummy._returnTransitionState("attacking")
