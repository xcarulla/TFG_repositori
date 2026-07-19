extends Control

@onready var main = $"../../"

func _on_resume_button_pressed() -> void:
	main.pauseMenu()


func _on_quit_button_pressed() -> void:
	main.pauseMenu()
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")
