extends Node

# -------------------------------
# DIFFICULTY RELATED GLOBAL VARS:
# -------------------------------

var difficulty := "normal" # easy normal hard
var deaths_count : int = 0
var timesUp : bool = false
var countdown_time : float = 120.0

var difficulty_types = {
	"parkour": "normal",
	"combat": "normal",
}

var enemyStats = {
	"easy": {
		"health": 1,
		"damage": 1,
		"speed": 3.0,
		"bullet_speed": 30,
	},
	"normal": {
		"health": 2,
		"damage": 2,
		"speed": 5.0,
		"bullet_speed": 70,
	},
	"hard": {
		"health": 3,
		"damage": 2,
		"speed": 6.0,
		"bullet_speed": 90,
	},
}

# ---------------------------
# PLAYER RELATED GLOBAL VARS:
# ---------------------------

var current_health : int

var playerStats = {
	"easy": {
		"health": 7,
		"invul_time": 1.0,
		"coyote_time": 0.15,
	},
	"normal": {
		"health": 6,
		"invul_time": 0.8,
		"coyote_time": 0.1,
	},
	"hard": {
		"health": 5,
		"invul_time": 0.5,
		"coyote_time": 0.07,
	},
}

# -------------------------------
# LEVEL RELATED GLOBAL VARS:
# -------------------------------

var current_level

var gameLevels = {
	"Level_0": {
		"cleared": false,
		"bestTime": "00:00:000"
	},
	"Level_1": {
		"cleared": false,
		"Stars": {
			"Star1" : false,
			"Star2" : false,
			"Star3" : false
		},
		"bestTime": "00:00:000"
	},
	"Level_2": {
		"cleared": false,
		"Stars": {
			"Star1" : false,
			"Star2" : false,
			"Star3" : false
		},
		"bestTime": "00:00:000"
	},
	"Level_3": {
		"cleared": false,
		"Stars": {
			"Star1" : false,
			"Star2" : false,
			"Star3" : false
		},
		"bestTime": "00:00:000"
	}
}

var current_spawn_point : Vector3

# -------------------------------
# LEVEL RELATED GLOBAL FUNCTIONS:
# -------------------------------

func resetLevel(nLevel: String):
	gameLevels[nLevel]["cleared"] = false
	gameLevels[nLevel]["Stars"] = {
		"Star1" : false,
		"Star2" : false,
		"Star3" : false
	}
	gameLevels[nLevel]["bestTime"] = "00:00:000"
	
func addStar(nLevel: String, nStar: String):
	gameLevels[nLevel]["Stars"][nStar] = true

func getStars(nLevel: String):
	return gameLevels[nLevel]["Stars"]

func updateSpawnPoint(_coords : Vector3) -> void:
	current_spawn_point = _coords

func change_diff(_diff_type : String, direction : String) -> void: # combat/parkour up/down
	var diff : String = difficulty_types[_diff_type]
	if direction == "down" and (diff == "normal" or diff == "easy"):
		difficulty_types[_diff_type] = "easy"
	elif (direction == "down" and diff == "hard") or (direction == "up" and diff == "easy"): 
		difficulty_types[_diff_type] = "normal"
	elif direction == "up" and (diff == "normal" or diff == "hard"):
		difficulty_types[_diff_type] = "hard"

func restartLevel() -> void:
	var path : String = "res://Scenes/"+current_level+".tscn"
	get_tree().change_scene_to_file(path)

func update_countdown_time() -> void:
	if current_level == "Level_0":
		countdown_time = 180.0
	if current_level == "Level_1":
		countdown_time = 90.0
	if current_level == "Level_2":
		countdown_time = 300.0
	if current_level == "Level_3":
		countdown_time = 500.0
