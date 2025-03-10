extends CharacterBody3D

const SPEED = 3.3

@export var target: Player
var distance := 0.5
var targetPosition: Vector3
var animationPlayer

func _ready():
	animationPlayer = $AnimationPlayer
	animationPlayer.play("key_float")


func _physics_process(_delta: float) -> void:
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
