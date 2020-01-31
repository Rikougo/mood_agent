extends Node



func _on_Play_pressed():
	get_tree().change_scene("res://scenes/hub.tscn")

func _on_Options_pressed():
	get_tree().change_scene("res://scenes/options.tscn")
