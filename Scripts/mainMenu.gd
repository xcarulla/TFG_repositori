extends Control

@export var anim_player: AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	#$"../Options Menu".position = Vector2(0,650) # BUG: per algun motiu sense aquesta linia sempre surt al 0,0 encara que el mogui
	anim_player.play("title_anim")


func _play():
	anim_player.play("showPlay")


func _options():
	anim_player.play("showOptions")


func _closePlay():
	anim_player.play("hidePlay")


func _closeOptions():
	anim_player.play("hideOptions")


func _quit():
	get_tree().quit()


# Change selected/visible level:
var currentLevel := "Level_1"

func leftArrow():
	pass


func rightArrow():
	pass


func _on_button_left_pressed() -> void:
	pass # Replace with function body.
