extends Camera3D

var randomStrength := 0.03
var shakeFade := 10.0

var random = RandomNumberGenerator.new()

var shake_strength := 0.0
@onready var normal_rotation = rotation

func _process(delta: float) -> void:
	if shake_strength > 0:
		shake_strength = lerpf(shake_strength, 0, shakeFade * delta)
		rotation = randomRotation()

func apply_shake():
	shake_strength = randomStrength

func randomRotation() -> Vector3:
	return Vector3(normal_rotation.x, random.randf_range(-shake_strength, shake_strength),normal_rotation.z)
