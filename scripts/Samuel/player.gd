extends KinematicBody2D

const SPEED   = 100
func _ready():
	pass
	
func _process(delta):
	var xStrenght = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	var yStrenght = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	var velocity = Vector2(xStrenght, yStrenght)
	
	move_and_slide(velocity * SPEED)
