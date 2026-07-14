extends Node


func calculate_parkour_difficulty(_t1 : float, _t2 : float, _falls : int):
	pass
	# primera mitat: 0 fallos 5.9 5.8
	#                1 fallo 15.3
	# segona mitat:  0 fallos 12.9 14.7
	#                1 fallo 30.5


func calculate_battle_difficulty(_final_hp : int):
	var new_diff : String
	var combat_diff_mult : float
	var deaths = GlobalVariables.deaths_count
	var max_hp : int = GlobalVariables.playerStats[GlobalVariables.difficulty]["health"]
	var hp_percentage : float = float(_final_hp) / float(max_hp)
	if hp_percentage >= 0.7 and deaths == 0:
		new_diff = "hard"
		combat_diff_mult = 1.5
	elif deaths > 0 and deaths <= 2:
		new_diff = "normal"
		combat_diff_mult = 1.0
	else:
		new_diff = "easy"
		combat_diff_mult = 0.5


func adjust_parkour_difficulty():
	pass

func adjust_battle_difficulty():
	pass
