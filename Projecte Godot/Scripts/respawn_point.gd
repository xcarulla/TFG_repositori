extends Node3D
class_name RespawnPoint

var spawnCoords : Vector3
var active : bool = false

var repairOff_ref
var repairOn_ref
var area_ref

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawnCoords = $spawnCoords.global_position
	repairOff_ref = $respawnPlataforma/repairOFF
	repairOff_ref.visible = true
	repairOn_ref = $respawnPlataforma/repairON
	repairOn_ref.visible = false
	area_ref = $Area3D

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.name == "Dummy" and !active:
		activateSpawnPoint()
		area_ref.set_deferred("monitoring", false)

func activateSpawnPoint() -> void:
	active = true
	lightSign()
	GlobalVariables.updateSpawnPoint(spawnCoords)

func lightSign() -> void:
	repairOff_ref.visible = false
	repairOn_ref.visible = true
