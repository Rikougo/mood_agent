extends KinematicBody2D

const MAX_SPEED = 1000
const ACCELERATION = 20
var motion = Vector2.ZERO
var type = "player"
	
func _physics_process(delta):	
	var axis = Vector2.ZERO
	axis.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	axis.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	axis = axis.normalized()
	
	if axis.x != 0 || axis.y != 0:
		motion = (motion + axis * ACCELERATION).clamped(MAX_SPEED)
	else:
		motion = motion.linear_interpolate(Vector2.ZERO, 0.1)
	
	#get_node("Particles").get_process_material().set_gravity(Vector3(motion.x * -1, motion.y * -1, 0)) 
	move_and_slide(motion)





