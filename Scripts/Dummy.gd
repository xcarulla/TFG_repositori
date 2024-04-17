extends CharacterBody3D


# Variables:
const MOVE_SPEED = 5
const JUMP_FORCE = 12
const GRAVITY = 10
const MAX_FALL_SPEED = 30
var y_vel = 0
var x_vel = 0
var facing_right = true

@onready var anim_tree = $anim_tree

func _ready():
	pass # Replace with function body.


func _process(delta):
	var move_dir = 0
	var grounded = is_on_floor()
	var just_jumped = false
	
	if Input.is_action_pressed("game_move_right"):
		move_dir += 1
	if Input.is_action_pressed("game_move_left"):
		move_dir -= 1
	
	move_and_slide()
	
	y_vel -= GRAVITY * delta
	if y_vel < -MAX_FALL_SPEED:
		y_vel = -MAX_FALL_SPEED
		
	if grounded:
		y_vel = -0.1
		if Input.is_action_pressed("game_jump"):
			y_vel = JUMP_FORCE
			just_jumped = true
	
	if move_dir < 0 and facing_right:
		_flip()
	if move_dir > 0 and !facing_right:
		_flip()
		
	if just_jumped:
		_changeAnimState("state","jump")
		_changeAnimState("attack","normal")
	elif grounded:
		_changeAnimState("state","grounded")
		_changeAnimState("attack","normal")
		if move_dir == 0:
			_changeAnimState("base_move/blend_position", 0)
		else:
			_changeAnimState("base_move/blend_position", 1)
			
func _flip():
	$Rig.rotation_degrees.y *= -1
	facing_right = !facing_right
	
func _changeAnimState(stateName, newState):
	anim_tree.set("parameters/%s" % stateName, newState)
	
