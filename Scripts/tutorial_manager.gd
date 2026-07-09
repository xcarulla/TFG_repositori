extends Node3D

var stopwatch : Stopwatch
var timer_in := false
var start_time : String
var start_ref : Area3D
var half_time : String
var half_ref : Area3D
var end_time : String
var end_ref : Area3D

var battle_area_ref : Area3D

var fall_counter : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	stopwatch = get_tree().get_first_node_in_group("stopwatch")
	start_ref = $startTimer
	half_ref = $halfTimer
	end_ref = $endTimer
	battle_area_ref = $battleArea

func count_fall(body):
	if body.name == "Dummy":
		fall_counter += 1


func parkour_start(body):
	if body.name == "Dummy":
		start_time = stopwatch.stopwatch_string()
		start_ref.set_deferred("monitoring", false)


func parkour_half(body):
	if body.name == "Dummy":
		half_time = stopwatch.stopwatch_string()
		half_ref.set_deferred("monitoring", false)


func parkour_end(body):
	if body.name == "Dummy":
		end_time = stopwatch.stopwatch_string()
		end_ref.set_deferred("monitoring", false)
		
		process_parkour_data()


func process_parkour_data() -> void:
	var start : float = stopwatch.time_to_float(start_time)
	var half : float = stopwatch.time_to_float(half_time)
	var end : float = stopwatch.time_to_float(end_time)
	
	var first_half : float = half - start
	var second_half : float = end - half
	DifficultyManager.calculate_parkour_difficulty(first_half, second_half, fall_counter)


func end_battle_area(body):
	if body.name == "Dummy":
		battle_area_ref.set_deferred("monitoring", false)
		DifficultyManager.calculate_battle_difficulty(body.get_player_hp())
