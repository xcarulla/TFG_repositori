extends Control

@onready var level0ref : Control = $Panel/Level_0
@onready var level1ref : Control = $Panel/Level_1
@onready var level2ref : Control = $Panel/Level_2
@onready var level3ref : Control = $Panel/Level_3

@onready var leftButton : TextureButton = $Panel/ButtonLeft
@onready var rightButton : TextureButton = $Panel/ButtonRight

var tutorial_done : bool = GlobalVariables.gameLevels["Level_0"]["cleared"]

var currentLevel : String

func _ready() -> void:
	if tutorial_done:
		currentLevel = "Level_1"
		changeLevel("Level_1")
		leftButton.visible = false
	else:
		currentLevel = "Level_0"
		changeLevel("Level_0")

func _on_button_left_pressed() -> void:
	if(currentLevel != "Level_1"):
		buttonVisibility("left", true)
		buttonVisibility("right", true)
	if(currentLevel == "Level_2"):
		buttonVisibility("left", false)
	previousLevel()

func _on_button_right_pressed() -> void:
	if(currentLevel != "Level_3"):
		buttonVisibility("left", true)
		buttonVisibility("right", true)
	if(currentLevel == "Level_2"):
		buttonVisibility("right", false)
	nextLevel()
	
func previousLevel() -> void:
	var level_number = int(currentLevel[-1])
	level_number -= 1
	var new_level = "Level_%d" % level_number
	changeLevel(new_level)
	
func nextLevel() -> void:
	var level_number = int(currentLevel[-1])
	level_number += 1
	var new_level = "Level_%d" % level_number
	changeLevel(new_level)

func changeLevel(level : String) -> void:
	currentLevel = level
	if(level == "Level_0"):
		level0ref.visible = true
	else:
		level0ref.visible = false
	if(level == "Level_1"):
		level1ref.visible = true
	else:
		level1ref.visible = false
		
	if(level == "Level_2"):
		level2ref.visible = true
	else:
		level2ref.visible = false
		
	if(level == "Level_3"):
		level3ref.visible = true
	else:
		level3ref.visible = false
	
func buttonVisibility(buttonSide : String, state : bool) -> void:
	if(buttonSide == "left"):
		leftButton.visible = state
	elif(buttonSide == "right"):
		rightButton.visible = state
