extends Node3D
class_name Teleport

# Variables
@onready var tp_coords =  position
@export var auraColor : Color
@export var paired_tp : Teleport
var ready_to_tp := true

func _ready() -> void:
	if auraColor != Color(0,0,0,1):
		$tp_vfx/Aura.process_material.color = auraColor

# Functions
func tp(player_area: Node3D):
	if paired_tp != null and ready_to_tp:
		# Fer animació abans de fer TP
		player_area.position = paired_tp.tp_coords
		paired_tp.ready_to_tp = false

func reset_state(_player_area: Node3D):
	ready_to_tp = true
