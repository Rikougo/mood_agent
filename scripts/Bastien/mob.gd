#extends Area2D
extends RigidBody2D

signal touch

export var min_speed = 150  # Minimum speed range.
export var max_speed = 250  # Maximum speed range.
var colorPossibility = ["purple", "green", "blue", "pink"] 
var color = colorPossibility[randi() % colorPossibility.size()]

func _ready():
	if (color == "purple"):
		modulate = Color(0.85,0.44,0.83)
		get_node("Light2D").set_color(Color(0.85,0.44,0.83))
	elif (color == "green"):
		modulate = Color(0,1,0)
		get_node("Light2D").set_color(Color(0,1,0))
	elif (color == "blue"):
		modulate = Color(0,0,1)
		get_node("Light2D").set_color(Color(0,0,1))
	else:
		modulate = Color(1,0,0.45)
		get_node("Light2D").set_color(Color(1,0,0.45))

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Wave_body_entered(body):
	emit_signal("touch")


