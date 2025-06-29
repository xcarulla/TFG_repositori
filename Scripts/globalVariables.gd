extends Node

# -------------------------------
# DIFFICULTY RELATED GLOBAL VARS:
# -------------------------------

var difficulty := "normal" # easy normal hard

var enemyStats = {
	"easy": {
		"health": 1,
		"damage": 1,
		"speed": 4.0,
	},
	"normal": {
		"health": 2,
		"damage": 1,
		"speed": 5.0,
	},
	"hard": {
		"health": 3,
		"damage": 2,
		"speed": 6.0,
	},
}

var playerStats = {
	"easy": {
		"health": 7,
		"invul_time": 1.0,
	},
	"normal": {
		"health": 5,
		"invul_time": 1.0,
	},
	"hard": {
		"health": 5,
		"invul_time": 0.8,
	},
}

var total_death_counter := 0

# -------------------------------
# LEVEL RELATED GLOBAL VARS:
# -------------------------------

var gameLevels = {
	"Level_1": {
		"cleared": false,
		"Stars": {
			"Star1" : false,
			"Star2" : false,
			"Star3" : false
		}
	},
	"Level_2": {
		"cleared": false,
		"Stars": {
			"Star1" : false,
			"Star2" : false,
			"Star3" : false
		}
	},
	"Level_3": {
		"cleared": false,
		"Stars": {
			"Star1" : false,
			"Star2" : false,
			"Star3" : false
		}
	}
}


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
