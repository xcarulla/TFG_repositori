extends Node3D
class_name hit_effect

var animator : AnimationPlayer

func _ready() -> void:
	animator = get_node("AnimationPlayer")
	
func playHitEffect() -> void:
	animator.play("hit")
