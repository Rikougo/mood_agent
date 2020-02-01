extends Node

enum LevelType{
	HUB,
	LEVEL
}

export var levelName : String
export (LevelType) var levelType = LevelType.HUB
