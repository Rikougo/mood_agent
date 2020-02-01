extends Node

onready var playButton = $CenterContainer/VBoxContainer/Play
onready var optionButton = $CenterContainer/VBoxContainer/Options

func _on_Play_pressed():
	get_tree().change_scene("res://scenes/Levels/Hub.tscn")

func _on_Options_pressed():
	get_tree().change_scene("res://scenes/Levels/Options.tscn")
