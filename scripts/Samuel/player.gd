extends KinematicBody2D

const MAX_SPEED = 1000
const ACCELERATION = 20
var motion = Vector2.ZERO

	
func _physics_process(delta):	
	var axis = Vector2.ZERO
	axis.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	axis.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	axis = axis.normalized()
	
	if axis.x != 0 || axis.y != 0:
		motion = (motion + axis * ACCELERATION).clamped(MAX_SPEED)
	else:
		motion = motion.linear_interpolate(Vector2.ZERO, 0.1)
	
	get_node("Particles").get_process_material().set_gravity(Vector3(motion.x * -1, motion.y * -1, 0)) 
	move_and_slide(motion)
	
func _input(event):
	if get_parent().levelType == get_parent().LevelType.HUB:
		if event.is_action_pressed("ui_accept"):
			if state == State.TEMPORAL:
				get_tree().change_scene("res://scenes/Levels/Temporal.tscn")
			if state == State.FRONTAL:
				get_tree().change_scene("res://scenes/Levels/Frontal.tscn")
			if state == State.OCCIPITAL:
				get_tree().change_scene("res://scenes/Levels/Occipital.tscn")
			if state == State.PARIETAL:
				get_tree().change_scene("res://scenes/Levels/Parietal.tscn")
# --- ON TOP PLAYER'S POP UP --- #

enum State{
	NORMAL,
	TEMPORAL,
	FRONTAL,
	PARIETAL,
	OCCIPITAL
}

const ZONES = ["Temporal", "Frontal", "Pariétal", "Occipital"]

var state = State.NORMAL

func _process(delta):
	if get_parent().levelType == get_parent().LevelType.HUB:
		if state == State.NORMAL:
			get_node("Top_Pop_Up").set_visible(false)
		else:
			get_node("Top_Pop_Up").set_visible(true)
			get_node("Top_Pop_Up/Label").set_text(ZONES[state-1] + " (entrer)")
		
func _on_Temporal_body_entered(body):
	print("t")
	if state == State.NORMAL and body == self:
		state = State.TEMPORAL

func _on_Temporal_body_exited(body):
	if state == State.TEMPORAL and body == self:
		state = State.NORMAL

func _on_Frontal_body_entered(body):
	if state == State.NORMAL and body == self:
		state = State.FRONTAL

func _on_Frontal_body_exited(body):
	if state == State.FRONTAL and body == self:
		state = State.NORMAL

func _on_Parietal_body_entered(body):
	if state == State.NORMAL and body == self:
		state = State.PARIETAL

func _on_Parietal_body_exited(body):
	if state == State.PARIETAL and body == self:
		state = State.NORMAL

func _on_Occipital_body_entered(body):
	if state == State.NORMAL and body == self:
		state = State.OCCIPITAL

func _on_Occipital_body_exited(body):
	if state == State.OCCIPITAL and body == self:
		state = State.NORMAL

