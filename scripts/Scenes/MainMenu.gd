extends Node

onready var playButton = $CenterContainer/VBoxContainer/Play
onready var optionButton = $CenterContainer/VBoxContainer/Options

onready var game = get_node("/root/Game")

func _on_Play_pressed():
	game.goto_scene(game.HUB)

func _on_Options_pressed():
	pass #parent.openOptions()
