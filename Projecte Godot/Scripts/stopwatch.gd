extends Node
class_name Stopwatch

var time = 0.0
var countdown_time = 120.0
var stopped = false

func _process(delta: float) -> void:
	if stopped:
		return
	time += delta # temps per diff normal
	countdown_time = max(countdown_time - delta, 0.0) # temps per diff hard
	
func reset():
	time = 0.0

func stopwatch_string() -> String:
	var ms = fmod(time, 1) * 1000
	var s = fmod(time, 60)
	var m = time / 60
	var format_string = "%02d : %02d : %02d"
	var final_string = format_string % [m, s, ms]
	return final_string
	
func countdown_string() -> String:
	var ms = fmod(countdown_time, 1) * 1000
	var s = fmod(countdown_time, 60)
	var m = countdown_time / 60
	var format_string = "%02d : %02d : %02d"
	var final_string = format_string % [m, s, ms]
	return final_string
	
func markTime() -> int:
	return time
	
func time_to_float(_temps_s : String) -> float:
	var m : float
	var s : float
	var ms : float
	m = _temps_s.get_slice(" : ", 0).to_float()
	s = _temps_s.get_slice(" : ", 1).to_float()
	ms = _temps_s.get_slice(" : ", 2).to_float()
	
	var temps : float
	temps = m * 60 + s + ms/1000

	return temps
