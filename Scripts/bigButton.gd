extends Button


var tween_hover: Tween

func _ready():
	size = Vector2(242,50)
	print(size)
	pivot_offset = Vector2(size.x/2, size.y/2)

func _on_mouse_entered():
	if tween_hover and tween_hover.is_running():
		tween_hover.kill()
	tween_hover = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	tween_hover.tween_property(self, "scale", Vector2(1.1, 1.1), 0.5)

func _on_mouse_exited():
	if tween_hover and tween_hover.is_running():
		tween_hover.kill()
	tween_hover = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	tween_hover.tween_property(self, "scale", Vector2.ONE, 0.55)
