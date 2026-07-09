extends Node3D

var starsDict
var pause_menu
var paused = false

var static_plats
var move_plats
var stopwatch : Stopwatch

@export var spawnPoint : Marker3D

func _ready():
	GlobalVariables.current_level = name
	GlobalVariables.updateSpawnPoint(spawnPoint.position)
	if GlobalVariables.current_level != "Level_0":
		static_plats = $Plataformes/Easy
		move_plats = $Plataformes/Normal
		starsDict = GlobalVariables.getStars(name)
		hideCollectedStars()
		# Plataformes
		if GlobalVariables.difficulty != "easy":
			hidePlatforms("static")
		if GlobalVariables.difficulty != "normal" and GlobalVariables.difficulty != "hard":
			hidePlatforms("move")
	stopwatch = get_tree().get_first_node_in_group("stopwatch")
	
	pause_menu = $CanvasLayer/PauseMenu
	# print(starsDict)
	

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


func pickUpStar(_nStar: String):
	GlobalVariables.addStar(name, _nStar)


func hidePlatforms(_type: String):
	if _type != "static":
		static_plats.visible = false
	if _type != "move":
		move_plats.visible = false

func endLevel():
	get_final_time()
	GlobalVariables.gameLevels[name]["cleared"] = true
	get_tree().call_deferred("change_scene_to_file","res://Scenes/menu.tscn")

func get_final_time():
	var final_time = stopwatch.stopwatch_string()
	GlobalVariables.gameLevels[name]["bestTime"] = stopwatch.time_to_float(final_time)
