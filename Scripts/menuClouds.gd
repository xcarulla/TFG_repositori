extends Node3D

# SCRIPT NO UTILITZAT

@export var cloud_speed: int
var clouds

# Called when the node enters the scene tree for the first time.
func _ready():
	clouds = get_children()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for cloud in clouds:
		cloud.position.x += cloud_speed * delta


func _on_area_3d_area_entered(area):
	area.get_parent().position.x = -70
