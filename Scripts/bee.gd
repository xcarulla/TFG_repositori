extends enemy

@onready var elevation_speed: float = deg_to_rad(150.0)
@onready var rotation_speed: float = deg_to_rad(150.0)

@onready var min_elevation: float = deg_to_rad(-80)
@onready var max_elevation: float = deg_to_rad(80)

@export var target : Player

var bee_range : float = 23.0
var target_position : Vector3
var active : bool
var bullet_scene
var bullet_speed : float
var is_shooting : bool = false

func _ready() -> void:
	check_active()
	bullet_scene = preload("res://Scenes/Bee_bullet.tscn")
	max_health = GlobalVariables.enemyStats[GlobalVariables.difficulty]["health"]
	damage = GlobalVariables.enemyStats[GlobalVariables.difficulty]["damage"]
	speed = GlobalVariables.enemyStats[GlobalVariables.difficulty]["speed"]
	bullet_speed = GlobalVariables.enemyStats[GlobalVariables.difficulty]["bullet_speed"]
	current_health = max_health

func _process(_delta: float) -> void:
	check_health()
	active = check_active()
	if !active:
		return
	if is_shooting:
		return
	start_shooting()

func check_health():
	if current_health <= 0:
		dead = true
		die()
		
func check_active() -> bool:
	if target == null:
		return false
	var distance : float = self.position.distance_to(target.position)
	if distance >= bee_range:
		return false
	return true

func _physics_process(delta: float) -> void: #Moviment
	if dead or !active:
		return
	target_position = target.get_player_pos()
	rotate_and_elevate(delta, target_position)

func rotate_and_elevate(delta : float, target_pos : Vector3) -> void:
	# Rotation
	var rotation_targ : Vector3 = get_projected(target_pos - self.global_position, self.global_basis.y)
	rotation_targ = rotation_targ + self.global_position
	
	var y_angle : float = angle_to_target(self.global_position, rotation_targ, self.global_basis.z)
	# La rotació horitzontal no indica el sentit, el calculem:
	var rotation_sign : float = sign(self.to_local(target_pos).x)
	
	var final_y : float = rotation_sign * min(rotation_speed * delta, y_angle)
	self.rotate_y(final_y)
	
	# Elevation
	var elevation_targ : Vector3 = get_projected(target_pos - self.global_position, self.global_basis.x)
	elevation_targ = elevation_targ + self.global_position
	
	var x_angle : float = angle_to_target(self.global_position, elevation_targ, self.global_basis.z)
	var elevation_sign : float = -sign(self.to_local(target_pos).y)
	
	var final_x : float = elevation_sign * min(elevation_speed * delta, x_angle)
	self.rotate_x(final_x)
	self.rotation.x = clamp(self.rotation.x, -max_elevation, -min_elevation)

func get_projected(pos : Vector3, normal : Vector3) -> Vector3:
	# Projecció de l'objectiu al pla indicat
	normal = normal.normalized()
	var projection : Vector3 = (pos.dot(normal) / normal.dot(normal)) * normal
	return pos - projection
	
func angle_to_target(pos : Vector3, target_pos : Vector3, direction : Vector3) -> float:
	# Angle de rotació fins l'objectiu en el pla indicat
	var dir = pos.direction_to(target_pos)
	direction = direction.normalized()
	dir = dir.normalized()
	return acos(direction.dot(dir))

func _on_damage_area_body_entered(body: Node3D) -> void:
	if body is Player:
		body.receive_damage(damage)

func start_shooting() -> void:
	is_shooting = true
	shoot()
	await get_tree().create_timer(0.5).timeout
	if active:
		start_shooting()
	else:
		is_shooting = false

func shoot() -> void:
	var bullet_instance : projectile = bullet_scene.instantiate() 
	add_sibling(bullet_instance)
	bullet_instance.transform = $BulletSpawnPoint.global_transform
	bullet_instance.linear_velocity = $BulletSpawnPoint.global_transform.basis.z * bullet_speed
