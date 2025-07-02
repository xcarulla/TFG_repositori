extends StaticBody3D

@export var activationArea: Area3D
var mesh
var coll
var doorOpen := false


func _ready():
	mesh = $doormesh
	coll = $CollisionShape3D
	activationArea.body_entered.connect(body_entered_area)
	#activationArea.body_exited.connect(body_exited_area)

func body_entered_area(body):
	if body.name == "Dummy" and doorOpen == false:
		if body.hasKey():
			doorOpen = true
			open()
			body.consumeKey()
		else:
			var ui = get_parent().get_node("UI")
			await get_tree().create_timer(1.0).timeout
			ui.activateHint("Maybe that enemy had something I need?")


# Animations:

func open():
	var tween_turn = create_tween()
	tween_turn.tween_property(mesh, "position", Vector3(0,3.8,0), 0.4).as_relative()
	await get_tree().create_timer(0.3).timeout
	coll.disabled = true
	
func close():
	var tween_turn = create_tween()
	tween_turn.tween_property(mesh, "position", Vector3(0,-4,0), 0.4).as_relative()
	await get_tree().create_timer(0.3).timeout
	coll.disabled = false
