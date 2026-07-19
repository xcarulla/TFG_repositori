extends Control

var starsDict
var bestTime : String

func _ready():
	if name != "Level_0":
		starsDict = GlobalVariables.getStars(name)
		bestTime = GlobalVariables.gameLevels[name]["bestTime"]
		setStarsVisibility()
		setBestTime()


func setStarsVisibility():
	var star = find_child("Star1")
	if starsDict["Star1"]:
		star.self_modulate = "#ffcb00"
	else:
		star.self_modulate = "#195598"
	
	star = find_child("Star2")
	if starsDict["Star2"]:
		star.self_modulate = "#ffcb00"
	else:
		star.self_modulate = "#195598"
	
	star = find_child("Star3")
	if starsDict["Star3"]:
		star.self_modulate = "#ffcb00"
	else:
		star.self_modulate = "#195598"

func setBestTime():
	var best_time_label = find_child("BestTimeLabel")
	best_time_label.text = bestTime

func _playLevel():
	get_tree().change_scene_to_file("res://Scenes/" + name + ".tscn")
