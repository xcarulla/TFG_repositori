extends Node

# -------------------------------
# DIFFICULTY RELATED GLOBAL VARS:
# -------------------------------

var difficulty := "normal" # easy normal hard

var enemyStats = {
	"easy": {
		"health": 1,
		"damage": 0,
	},
	"normal": {
		"health": 2,
		"damage": 1,
	},
	"hard": {
		"health": 3,
		"damage": 3,
	},
}

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
