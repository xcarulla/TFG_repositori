extends CharacterBody3D
class_name Player

# Variables:
@export var move_speed = 10
@export var jump_height : float
@export var jump_time_to_peak : float
@export var jump_time_to_descend : float
@export var jump_buffer_time : float
@export var coyote_time : float

@onready var jump_velocity : float = (2.0 * jump_height) / jump_time_to_peak
@onready var jump_gravity : float = (-2.0 * jump_height) / pow(jump_time_to_peak,2)
@onready var fall_gravity : float = (-2.0 * jump_height) / pow(jump_time_to_descend,2)
@onready var jump_buffer_timer : float = 0
@onready var coyote_timer : float = 0
@onready var anim_tree = $anim_tree
var facing_right : bool = true
var jump_in_queue : bool = false
var was_on_floor : bool = false
var still_can_jump : bool = false
var is_attacking : bool = false

var anim_stateAttacking = ""
var anim_stateGrounded = ""
var anim_stateAttacks = ""

func _process(delta):
	jump_buffer_timer -= delta
	coyote_timer -= delta

func _physics_process(delta):
	var move_dir
	var grounded = is_on_floor()
	
	# Gravity
	velocity.y += get_current_gravity() * delta
	
	# Movement
	move_dir = _update_input()
	velocity.x = move_dir * move_speed
	
	# Update coyote
	if was_on_floor and !grounded:
		coyote_timer = coyote_time
	# Update jump buffer
	if Input.is_action_pressed("game_jump"):
		jump_buffer_timer = jump_buffer_time
	jump_in_queue = jump_buffer_timer > 0
	# Jump (Si ha apretat el salt dins del temps del buffer i esta tocant el terra o dins de la finestra del coyote salta)
	if jump_in_queue and (grounded or coyote_timer > 0):
		_jump()
	else:
		was_on_floor = grounded
	
	move_and_slide()
	
	if Input.is_action_just_pressed("game_attack_light"):
		is_attacking = true
	
	# Flipping the character
	if move_dir < 0 and facing_right:
		_flip()
	if move_dir > 0 and !facing_right:
		_flip()
	
	# Animations
	if grounded:
		_changeAnimState("grounded","yes")
		if is_attacking: # attack
			is_attacking = false
			_changeAnimState("attacking/request",AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
			_changeAnimState("attacks","light_attack")
		if move_dir == 0: # idle
			_changeAnimState("base_move/blend_position", 0)
		else: # run
			_changeAnimState("base_move/blend_position", 1)
	else: # jump
		_changeAnimState("grounded","no")


func get_current_gravity() -> float:
	return jump_gravity if velocity.y < 0.0 else fall_gravity
	
func _update_input() -> float:
	var move_dir = 0
	if Input.is_action_pressed("game_move_right"):
		move_dir += 1
	if Input.is_action_pressed("game_move_left"):
		move_dir -= 1
	return move_dir
	
func _jump():
	velocity.y = jump_velocity
	was_on_floor = false
	
func _flip():
	$Rig.rotation_degrees.y *= -1
	facing_right = !facing_right
	
func _changeAnimState(stateName, newState):
	match stateName:
		"attacking":
			anim_stateAttacking = newState
		"grounded":
			anim_stateGrounded = newState
		"attacks":
			anim_stateAttacks = newState
	anim_tree.set("parameters/%s" % stateName, newState)

func _returnTransitionState(transition:String):
	match transition:
		"attacking":
			return anim_stateAttacking
		"grounded":
			return anim_stateGrounded
		"attacks":
			return anim_stateAttacks
		_:
			return ""
	
