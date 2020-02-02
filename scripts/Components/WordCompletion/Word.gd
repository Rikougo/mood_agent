extends RigidBody2D

export var WORDS = ["", ""]
export (int, 0, 4, 1) var color
var current = 0
var velocity = Vector2()
var length

func _ready():
	set_bounce(0.8)
	collision_layer = pow(2, color)
	$Label.text = WORDS[current]
	if color: modulate = Colors.POOL[color]
	length = $Label.text.length()
	$CollisionShape2D._update(length)

func _update():
	if current == 1:
		return
	current += 1
	$Label.text = WORDS[current]
	length = $Label.text.length()
	$CollisionShape2D._update(length)

func _physics_process(delta):
	velocity = get_linear_velocity()
	velocity = velocity.linear_interpolate(Vector2.ZERO, 0.05)
	set_axis_velocity(velocity)
