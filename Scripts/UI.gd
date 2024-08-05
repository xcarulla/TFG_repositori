extends Control

@export var currentLevel: String
@export var dummy: CharacterBody3D
var grounded
var attacking
var attackType

var levelname1
var levelstars1
var levelname2
var levelstars2
var levelname3
var levelstars3

func _ready():
	grounded = $AnimationStates/GridContainer/grounded
	attacking = $AnimationStates/GridContainer/attacking
	attackType = $AnimationStates/GridContainer/attackType
	
	levelname1 = $Stars/GridContainer/level1name
	levelstars1 = $Stars/GridContainer/starsCollected1
	levelname2 = $Stars/GridContainer/level2name
	levelstars2 = $Stars/GridContainer/starsCollected2
	levelname3 = $Stars/GridContainer/level3name
	levelstars3 = $Stars/GridContainer/starsCollected3

func _process(_delta):
	grounded.text = dummy._returnTransitionState("grounded")
	attacking.text = dummy._returnTransitionState("attacking")
	attackType.text = dummy._returnTransitionState("attacks")
	
	levelname1.text = "level 1"
	levelstars1.text = str(GlobalVariables.gameLevels[currentLevel]["Stars"]["Star1"]) + " " + str(GlobalVariables.gameLevels[currentLevel]["Stars"]["Star2"]) + " " + str(GlobalVariables.gameLevels[currentLevel]["Stars"]["Star3"])
