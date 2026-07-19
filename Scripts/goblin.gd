extends enemy

@export var direction := Vector3(1,0,0)

var facing_right : bool = true
var turning := false

func _ready() -> void:
	max_health = GlobalVariables.enemyStats[GlobalVariables.difficulty]["health"]
	damage = GlobalVariables.enemyStats[GlobalVariables.difficulty]["damage"]
	speed = GlobalVariables.enemyStats[GlobalVariables.difficulty_types["combat"]]["speed"]
	current_health = max_health

func _process(_delta: float) -> void:
	check_health()

func check_health():
	if current_health <= 0:
		dead = true
		die()

func _physics_process(delta: float) -> void: #Moviment
	if !dead:
		velocity.x = speed * direction.x
	else: velocity.x = 0.0
	
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
		
		facing_right = !facing_right
		
		tween_turn.tween_property(self, "rotation_degrees", Vector3(0,180,0), 0.4).as_relative()
		
		await get_tree().create_timer(0.5).timeout
		
		direction.x = dir.x * -1
		
		turning = false

func _on_damage_area_body_entered(body: Node3D) -> void:
	if body is Player:
		body.receive_damage(damage)
