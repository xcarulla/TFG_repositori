extends Node3D

var starsDict

func _ready():
	starsDict = GlobalVariables.getStars(name)
	# print(starsDict)
	hideCollectedStars()


func hideCollectedStars():
	if starsDict["Star1"]:
		find_child("Star1").visible = false
	if starsDict["Star2"]:
		find_child("Star2").visible = false
	if starsDict["Star3"]:
		find_child("Star3").visible = false


func pickUpStar(nStar: String):
	GlobalVariables.addStar(name, nStar)

func endLevel():
	GlobalVariables.gameLevels[name]["cleared"] = true
	get_tree().call_deferred("change_scene_to_file","res://Scenes/menu.tscn")
