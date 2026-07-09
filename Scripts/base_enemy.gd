extends CharacterBody3D
class_name enemy

var max_health
var current_health
var speed
var damage
var grounded : bool
var dead : bool = false

@export var animationPlayer : AnimationPlayer
@export var dmg_area_ref : Area3D
@export var hurt_area_ref : Area3D

func recive_dmg():
	if !dead:
		animationPlayer.play("HitRecieve")
		current_health -= 1
		print("enemy hp: ",current_health)

func die():
	if dmg_area_ref != null: dmg_area_ref.set_deferred("monitoring", false)
	if hurt_area_ref != null: hurt_area_ref.set_deferred("monitoring", false)
	animationPlayer.play("Death")
	await get_tree().create_timer(1).timeout
	queue_free()
