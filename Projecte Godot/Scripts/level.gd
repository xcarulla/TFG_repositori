extends Node3D

var starsDict
var pause_menu
var paused = false

var stopwatch : Stopwatch

var death_count_at_start : int

@export var spawnPoint : Marker3D

func _ready():
	death_count_at_start = GlobalVariables.deaths_count
	GlobalVariables.current_level = name
	GlobalVariables.updateSpawnPoint(spawnPoint.position)
	if GlobalVariables.current_level != "Level_0":
		starsDict = GlobalVariables.getStars(name)
		hideCollectedStars()
	else:
		GlobalVariables.deaths_count = 0
	stopwatch = get_tree().get_first_node_in_group("stopwatch")
	
	pause_menu = $CanvasLayer/PauseMenu
	

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


func endLevel():
	get_final_time()
	manage_difficulty()
	GlobalVariables.gameLevels[name]["cleared"] = true
	get_tree().call_deferred("change_scene_to_file","res://Scenes/menu.tscn")

func get_final_time():
	var final_time = stopwatch.stopwatch_string()
	var float_actual : float = stopwatch.time_to_float(final_time)
	
	var bestTime = GlobalVariables.gameLevels[name]["bestTime"]
	var float_best : float = stopwatch.time_to_float(bestTime)
	
	if float_actual < float_best or float_best == 0.0:
		GlobalVariables.gameLevels[name]["bestTime"] = final_time

func manage_difficulty():
	var new_deaths : int = GlobalVariables.deaths_count - death_count_at_start
	DifficultyManager.adjust_battle_difficulty(new_deaths)
