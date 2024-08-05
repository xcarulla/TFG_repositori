extends Node

var gameLevels = {
	"firstLevel": {
		"cleared": false,
		"Stars": {
			"Star1" : false,
			"Star2" : false,
			"Star3" : false
		}
	},
	"secondLevel": {
		"cleared": false,
		"Stars": {
			"Star1" : false,
			"Star2" : false,
			"Star3" : false
		}
	},
	"thirdLevel": {
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
