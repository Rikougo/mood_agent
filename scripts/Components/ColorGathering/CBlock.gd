extends RigidBody2D

const Colors = preload("res://scripts/Global/Colors.gd")

export var color = Colors.PURPLE
var velocity = Vector2()

func _ready():
	set_bounce(0.8)
	modulate = Colors.POOL[color]

func _physics_process(delta):
	velocity = get_linear_velocity()
	
	velocity = velocity.linear_interpolate(Vector2.ZERO, 0.03)
	set_axis_velocity(velocity)
