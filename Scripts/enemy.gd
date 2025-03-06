extends CharacterBody3D


const SPEED = 5.0

@export var direction := Vector3(1,0,0)
var turning := false

func _physics_process(delta: float) -> void:
	
	velocity.x = SPEED * direction.x
	
	# Gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	move_and_slide()
	
	if is_on_wall() and not turning:
		turning = true
		var dir = direction
		direction = Vector3.ZERO
		
		# turn enemy 3d model:
		var tween_turn = create_tween()
		tween_turn.tween_property(self, "rotation_degrees", Vector3(0,180,0), 0.4).as_relative()
		
		await get_tree().create_timer(0.5).timeout
		
		direction.x = dir.x * -1
		turning = false

	
