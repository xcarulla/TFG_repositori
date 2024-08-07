extends Node3D
class_name Teleport

# Variables
@onready var tp_coords =  position
@export var paired_tp : Teleport
var ready_to_tp := true

# Functions
func tp(player_area: Node3D):
	if paired_tp != null and ready_to_tp:
		player_area.position = paired_tp.tp_coords
		paired_tp.ready_to_tp = false

func reset_state(_player_area: Node3D):
	ready_to_tp = true
