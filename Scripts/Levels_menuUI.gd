extends Control

var starsDict


func _ready():
	starsDict = GlobalVariables.getStars(name)
	setStarsVisibility()


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


func _playLevel():
	get_tree().change_scene_to_file("res://Scenes/" + name + ".tscn")
