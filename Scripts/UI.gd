extends Control

# !!!!!!!!!!!!!!!!!!!!!
# !!!!! Variables !!!!!
# !!!!!!!!!!!!!!!!!!!!!

@export var dummy: CharacterBody3D
@onready var anim_player: AnimationPlayer = $AnimationPlayer

@onready var hint_text = $Hint/Panel/HintContent
var hint_active = false

func _ready():
	setDebugVars()

func _process(_delta):
	updateDebugVars()
	
	
# !!!!!!!!!!!!!!!!!!!!!!!!!!
# !!!!! HINT FUNCTIONS !!!!!
# !!!!!!!!!!!!!!!!!!!!!!!!!!

func activateHint(text : String) -> void:
	if hint_active:
		return
		
	hint_text.text = text
	showHint()
	await get_tree().create_timer(5.0).timeout
	hideHint()

func showHint() -> void:
	hint_active = true
	anim_player.play("show_hint")

func hideHint() -> void:
	anim_player.play("hide_hint")
	hint_active = false


# !!!!!!!!!!!!!!!!!!!!!!!!!
# !!!!! DEBUG RELATED !!!!!
# !!!!!!!!!!!!!!!!!!!!!!!!!

var currentLevel
var grounded
var attacking
var attackType
var levelname1
var levelstars1
var levelname2
var levelstars2
var levelname3
var levelstars3

func setDebugVars() -> void:
	currentLevel = get_parent().name
	grounded = $Debug/AnimationStates/GridContainer/grounded
	attacking = $Debug/AnimationStates/GridContainer/attacking
	attackType = $Debug/AnimationStates/GridContainer/attackType
	
	levelname1 = $Debug/Stars/GridContainer/level1name
	levelstars1 = $Debug/Stars/GridContainer/starsCollected1
	levelname2 = $Debug/Stars/GridContainer/level2name
	levelstars2 = $Debug/Stars/GridContainer/starsCollected2
	levelname3 = $Debug/Stars/GridContainer/level3name
	levelstars3 = $Debug/Stars/GridContainer/starsCollected3
	
func updateDebugVars() -> void:
	grounded.text = dummy._returnTransitionState("grounded")
	attacking.text = dummy._returnTransitionState("attacking")
	attackType.text = dummy._returnTransitionState("attacks")
	
	levelname1.text = get_parent().name
	levelstars1.text = str(GlobalVariables.gameLevels[get_parent().name]["Stars"]["Star1"]) + " " + str(GlobalVariables.gameLevels[get_parent().name]["Stars"]["Star2"]) + " " + str(GlobalVariables.gameLevels[get_parent().name]["Stars"]["Star3"])
