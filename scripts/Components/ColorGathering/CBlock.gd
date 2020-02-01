extends RigidBody2D

var velocity = Vector2()

func _ready():
	set_bounce(0.8)

func _physics_process(delta):
	velocity = get_linear_velocity()
	
	velocity = velocity.linear_interpolate(Vector2.ZERO, 0.05)
	set_axis_velocity(velocity)
