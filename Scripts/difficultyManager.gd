extends Node


func calculate_parkour_difficulty(_t1 : float, _t2 : float, _falls : int):
	var counter : int = 0
	
	if _t1 <= 8.0:
		counter += 2
	elif _t1 > 8.0 and _t1 <= 18.0:
		counter += 1
	
	if _t2 <= 16.0:
		counter += 2
	elif _t2 > 16.0 and _t2 <= 33.0:
		counter += 1
		
	if _falls == 0:
		counter += 2
	elif _falls >= 1 and _falls <= 3:
		counter += 1
	
	if counter >= 5:
		GlobalVariables.difficulty_types["parkour"] = "hard"
	elif counter < 5 and counter >= 3:
		GlobalVariables.difficulty_types["parkour"] = "normal"
	else:
		GlobalVariables.difficulty_types["parkour"] = "easy"

func calculate_battle_difficulty(_final_hp : int):
	var deaths = GlobalVariables.deaths_count
	var max_hp : int = GlobalVariables.playerStats[GlobalVariables.difficulty]["health"]
	var hp_percentage : float = float(_final_hp) / float(max_hp)
	if hp_percentage >= 0.5 and deaths == 0:
		GlobalVariables.difficulty_types["combat"] = "hard"
	elif deaths > 0 and deaths <= 2:
		GlobalVariables.difficulty_types["combat"] = "normal"
	else:
		GlobalVariables.difficulty_types["combat"] = "easy"

func adjust_battle_difficulty(_newDeaths : int):
	if _newDeaths <= 1:
		GlobalVariables.change_diff("combat", "up")
	if _newDeaths > 1 and _newDeaths <= 3:
		pass
	else:
		GlobalVariables.change_diff("combat", "down")
		
