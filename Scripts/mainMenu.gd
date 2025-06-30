extends Control

@export var anim_player: AnimationPlayer
@onready var diffText = $VBoxContainer/DiffText

# Called when the node enters the scene tree for the first time.
func _ready():
	#$"../Options Menu".position = Vector2(0,650) # BUG: per algun motiu sense aquesta linia sempre surt al 0,0 encara que el mogui
	anim_player.play("title_anim")
	diffText.text = GlobalVariables.difficulty.capitalize()


func _play():
	anim_player.play("showPlay")

func _closePlay():
	anim_player.play("hidePlay")

func _changeDiff():
	var current_diff = GlobalVariables.difficulty
	if current_diff == "easy":
		GlobalVariables.difficulty = "normal"
	elif current_diff == "normal":
		GlobalVariables.difficulty = "hard"
	elif current_diff == "hard":
		GlobalVariables.difficulty = "easy"
	diffText.text = GlobalVariables.difficulty.capitalize()

func _options():
	anim_player.play("showOptions")

func _closeOptions():
	anim_player.play("hideOptions")

func _showCredits():
	anim_player.play("showCredits")
	print("credits")

func _closeCredits():
	anim_player.play("closeCredits")
	print("close credits")

func _quit():
	get_tree().quit()
