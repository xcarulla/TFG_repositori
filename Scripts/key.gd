extends CharacterBody3D
class_name Key

const SPEED = 3.3

@export var target: CharacterBody3D
var distance := 0.5
var targetPosition: Vector3
var animationPlayer
var player
func _ready():
	animationPlayer = $AnimationPlayer
	animationPlayer.play("key_float")
	player = get_parent().get_node("Dummy")

func attach_to_player():
	player.playerHasKey = true
	target = player
	
func use_key():
	player.playerHasKey = false
	queue_free()


func _physics_process(_delta: float) -> void:
	if target != null:
		calculate_velocity()
	move_and_slide()
	
func calculate_velocity():
	if target.facing_right:
		targetPosition = target.position - Vector3(2,-2.5,0)
	else:
		targetPosition = target.position - Vector3(-2,-2.5,0)
		
	if position.distance_to(targetPosition) > distance*4:
		var direction = (targetPosition - position).normalized()
		velocity = direction * SPEED
		velocity *= 5
	elif position.distance_to(targetPosition) > distance:
		var direction = (targetPosition - position).normalized()
		velocity = direction * SPEED
		velocity *= 3
	else:
		velocity = Vector3.ZERO
