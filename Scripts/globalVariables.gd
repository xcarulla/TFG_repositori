extends Node

# -------------------------------
# DIFFICULTY RELATED GLOBAL VARS:
# -------------------------------

var difficulty := "normal" # easy normal hard
var current_level
var deaths_count : int = 0

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
		"health": 5,
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

var gameLevels = {
	"Level_0": {
		"cleared": false,
		"bestTime": 0.0
	},
	"Level_1": {
		"cleared": false,
		"Stars": {
			"Star1" : false,
			"Star2" : false,
			"Star3" : false
		},
		"bestTime": 0.0
	},
	"Level_2": {
		"cleared": false,
		"Stars": {
			"Star1" : false,
			"Star2" : false,
			"Star3" : false
		},
		"bestTime": 0.0
	},
	"Level_3": {
		"cleared": false,
		"Stars": {
			"Star1" : false,
			"Star2" : false,
			"Star3" : false
		},
		"bestTime": 0.0
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
	
func addStar(nLevel: String, nStar: String):
	gameLevels[nLevel]["Stars"][nStar] = true

func getStars(nLevel: String):
	return gameLevels[nLevel]["Stars"]

func updateSpawnPoint(_coords : Vector3) -> void:
	current_spawn_point = _coords
