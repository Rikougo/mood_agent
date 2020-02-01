#extends Area2D
extends RigidBody2D

const Colors = preload("res://scripts/Global/Colors.gd")

signal touch

export var min_speed = 150  # Minimum speed range.
export var max_speed = 250  # Maximum speed range.
const COLORS = [Color(0, 0, 0),
				Color(0.85, 0.44, 0.83),
				Color(0, 1, 0),
				Color(0, 0, 1),
				Color(1, 0, 0.45)]
var color = int(rand_range(1.0, 5.0))

func _ready():
	modulate = COLORS[color]
	get_node("Light2D").set_color(COLORS[color])

# warning-ignore:unused_argument
func _on_Mob_body_entered(_body):
	emit_signal("touch")
