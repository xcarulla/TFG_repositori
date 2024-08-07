extends Node3D

func _on_area_3d_body_entered(body):
	if body.name == "Dummy":
		endLevel()
		
func endLevel():
	get_tree().change_scene_to_file("res://Scenes/menu.tscn") # TEMPORAL -> causa errors ?
