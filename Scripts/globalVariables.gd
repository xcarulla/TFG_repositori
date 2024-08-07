extends Node

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
