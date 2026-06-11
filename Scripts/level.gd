extends Node3D

var starsDict
var pause_menu
var paused = false

@onready var easy = $Plataformes/Easy
@onready var normal = $Plataformes/Normal
@onready var hard = $Plataformes/Hard

func _ready():
	starsDict = GlobalVariables.getStars(name)
	pause_menu = $CanvasLayer/PauseMenu
	# print(starsDict)
	hideCollectedStars()
	# Plataformes
	if GlobalVariables.difficulty != "easy":
		hidePlatforms("easy")
	if GlobalVariables.difficulty != "normal":
		hidePlatforms("normal")
	if GlobalVariables.difficulty != "hard":
		hidePlatforms("hard")


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("game_pause"):
		pauseMenu()
		
func pauseMenu():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
		
	paused = !paused


func hideCollectedStars():
	if starsDict["Star1"]:
		find_child("Star1").visible = false
	if starsDict["Star2"]:
		find_child("Star2").visible = false
	if starsDict["Star3"]:
		find_child("Star3").visible = false


func pickUpStar(nStar: String):
	GlobalVariables.addStar(name, nStar)


func hidePlatforms(diff: String):
	if GlobalVariables.difficulty != "easy":
		easy.visible = false
	if GlobalVariables.difficulty != "normal":
		normal.visible = false
	if GlobalVariables.difficulty != "hard":
		hard.visible = false


func endLevel():
	GlobalVariables.gameLevels[name]["cleared"] = true
	get_tree().call_deferred("change_scene_to_file","res://Scenes/menu.tscn")
