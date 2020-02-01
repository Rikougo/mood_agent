extends Node

func _on_Play_pressed():
	get_tree().change_scene("res://scenes/Hub.tscn")

func _on_Options_pressed():
	get_tree().change_scene("res://scenes/Options.tscn")
