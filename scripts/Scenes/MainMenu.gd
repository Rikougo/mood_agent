extends Node

onready var playButton = $CenterContainer/VBoxContainer/Play
onready var optionButton = $CenterContainer/VBoxContainer/Options

onready var parent = get_parent()

func _on_Play_pressed():
	parent.startGame()

func _on_Options_pressed():
	pass #parent.openOptions()
