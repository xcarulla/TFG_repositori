extends CharacterBody3D

# Variables:
@export var move_speed = 10
@export var jump_height : float
@export var jump_time_to_peak : float
@export var jump_time_to_descend : float
@export var jump_buffer_time : float

@onready var jump_velocity : float = (2.0 * jump_height) / jump_time_to_peak
@onready var jump_gravity : float = (-2.0 * jump_height) / pow(jump_time_to_peak,2)
@onready var fall_gravity : float = (-2.0 * jump_height) / pow(jump_time_to_descend,2)
@onready var jump_buffer_timer : float = 0
@onready var anim_tree = $anim_tree
var facing_right : bool = true
var jump_in_queue : bool = false

func _process(delta):
	jump_buffer_timer -= delta

func _physics_process(delta):
	var move_dir = 0
	var grounded = is_on_floor()
	var just_jumped = false
	
	# Gravity
	velocity.y += get_gravity() * delta
	
	# Movement
	move_dir = _update_input()
	velocity.x = move_dir * move_speed
	
	# Jump
	if (Input.is_action_pressed("game_jump") or jump_in_queue) and grounded:
		_jump()
		if jump_in_queue: jump_in_queue = false
	
	move_and_slide()
	
	# Flipping the character
	if move_dir < 0 and facing_right:
		_flip()
	if move_dir > 0 and !facing_right:
		_flip()
	
	# Animations
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

func get_gravity() -> float:
	return jump_gravity if velocity.y < 0.0 else fall_gravity
	
func _update_input() -> float:
	var move_dir = 0
	if Input.is_action_pressed("game_move_right"):
		move_dir += 1
	if Input.is_action_pressed("game_move_left"):
		move_dir -= 1
	return move_dir

func _flip():
	$Rig.rotation_degrees.y *= -1
	facing_right = !facing_right
	
func _changeAnimState(stateName, newState):
	anim_tree.set("parameters/%s" % stateName, newState)
	
func _jump():
	velocity.y = jump_velocity
	jump_buffer_timer = jump_buffer_time
