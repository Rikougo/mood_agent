extends KinematicBody2D

const SPEED = 100

func _ready():
	pass
	
func _process(delta):
	var velocity = Vector2(0, 100)
	if Input.is_action_pressed("ui_right"):
		velocity.x += 100
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 100
	
	move_and_slide(velocity)
