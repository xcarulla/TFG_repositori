extends CharacterBody3D
class_name Player

# Variables:

@export var move_speed = 10
@export var jump_height : float
@export var jump_time_to_peak : float
@export var jump_time_to_descend : float
@export var jump_buffer_time : float
var coyote_time : float = GlobalVariables.playerStats[GlobalVariables.difficulty_types["parkour"]]["coyote_time"]
var max_health = GlobalVariables.playerStats[GlobalVariables.difficulty]["health"]
var is_invulnerable := false
var invulnerability_time : float = GlobalVariables.playerStats[GlobalVariables.difficulty_types["combat"]]["invul_time"]

@export var camera : Camera3D
@export var hitVFX : hit_effect

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

var playerHasKey := false
var key_ref : Key

func _ready():
	GlobalVariables.current_health = max_health

# Movement, physics and input management:
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

func _on_area_3d_light_area_entered(area: Area3D) -> void:
	# Area d'atac (hit box)
	if area.name == "hurtBox":
		var objective = area.get_parent()
		hitVFX.playHitEffect()
		objective.recive_dmg()

# Health and recieving damage :

func receive_damage(dmg: int):
	if is_invulnerable:
		return
	var real_health = GlobalVariables.current_health
	real_health -= dmg
	GlobalVariables.current_health = max(real_health, 0)
	camera.apply_shake()
	
	if GlobalVariables.current_health <= 0:
		die()
	else:
		is_invulnerable = true
		invul_effect()
		start_invulnerability_timer()
		
func die():
	print("Player is dead")
	GlobalVariables.deaths_count += 1
	respawn()

func respawn():
	GlobalVariables.current_health = max_health
	position = GlobalVariables.current_spawn_point

func start_invulnerability_timer():
	await get_tree().create_timer(invulnerability_time).timeout
	is_invulnerable = false

func invul_effect():
	pass #fer flash 

func get_player_pos() -> Vector3:
	return $Rig/Skeleton3D/Dummy_TargetOnHisBack.global_position

func get_player_hp() -> int:
	return GlobalVariables.current_health

# Key related:

func hasKey() -> bool:
	return playerHasKey

func assign_key(key: Key) -> void:
	key_ref = key

func consumeKey() -> void:
	key_ref.use_key()
	key_ref = null
