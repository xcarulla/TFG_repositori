extends Control

# !!!!!!!!!!!!!!!!!!!!!
# !!!!! Variables !!!!!
# !!!!!!!!!!!!!!!!!!!!!

@export var dummy: CharacterBody3D
@export var stopwatch_label : RichTextLabel
@export var countdown_label : RichTextLabel
@export var health_container : HBoxContainer

@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var hint_text = $Hint/Panel/HintContent

@onready var ui_heart_ref = preload("res://Scenes/UI_heart.tscn")
var displayed_hp : int = 0

var hint_active = false
var stopwatch : Stopwatch
var diff : String

func _ready():
	stopwatch_label.visible = false
	countdown_label.visible = false
	diff = GlobalVariables.difficulty
	if diff == "normal":
		stopwatch_label.visible = true
	if diff == "hard":
		countdown_label.visible = true
	stopwatch = get_tree().get_first_node_in_group("stopwatch")
	
	update_displayed_hp()
	
	# Debug
	setDebugVars()

func _process(_delta):
	if diff == "normal":
		update_stopwatch_label()
	if diff == "hard":
		update_countdown_label()
	
	if displayed_hp != GlobalVariables.current_health:
		update_displayed_hp()
	
	# Debug
	updateDebugVars()


func update_displayed_hp() -> void:
	var variation : int = GlobalVariables.current_health - displayed_hp
	if variation > 0:
		# Afegir cors
		var heart_ref
		for n in variation:
			heart_ref = ui_heart_ref.instantiate()
			health_container.add_child(heart_ref)
	elif variation < 0:
		# Treure cors
		for n in abs(variation):
			health_container.get_child(n).queue_free()
	displayed_hp = GlobalVariables.current_health

# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# !!!!! STOPWATCH FUNCTIONS !!!!!
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	
func update_stopwatch_label():
	stopwatch_label.text = stopwatch.stopwatch_string()

func update_countdown_label():
	countdown_label.text = stopwatch.countdown_string()

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


# !!!!!!!!!!!!!!!!!
# !!!!! DEBUG !!!!!
# !!!!!!!!!!!!!!!!!

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
	if levelname1.text != "Level_0":
		levelstars1.text = str(GlobalVariables.gameLevels[get_parent().name]["Stars"]["Star1"]) + " " + str(GlobalVariables.gameLevels[get_parent().name]["Stars"]["Star2"]) + " " + str(GlobalVariables.gameLevels[get_parent().name]["Stars"]["Star3"])
