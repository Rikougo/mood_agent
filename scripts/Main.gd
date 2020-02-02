extends Node

onready var game = get_node("/root/Game")

func _ready():
	game.goto_scene(game.MAIN_MENU)
