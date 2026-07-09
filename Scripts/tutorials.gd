extends Area3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func body_entered_area(body):
	if body.name == "Dummy":
		var ui = get_parent().get_node("UI")
		ui.activateHint("Press Space to jump!")

func body_entered_area_attack(body):
	if body.name == "Dummy":
		var ui = get_parent().get_node("UI")
		ui.activateHint("Left click to attack!")
