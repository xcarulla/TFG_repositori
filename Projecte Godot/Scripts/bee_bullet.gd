extends Node3D
class_name projectile

func _ready() -> void:
	despawn_timer()

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.name == "Dummy":
		body.receive_damage(1)
		queue_free()

func despawn_timer() -> void:
	await get_tree().create_timer(1.5).timeout
	queue_free()

func _on_body_entered(body: Node) -> void:
	print(body.name)
