extends KinematicBody2D

const Colors = preload("res://scripts/Global/Colors.gd")

enum State{
	NORMAL,
	TEMPORAL,
	FRONTAL,
	PARIETAL,
	OCCIPITAL,
	LETTER,
	INCAPACITATE
}

const MAX_SPEED = 1000
const ACCELERATION = 20
var motion = Vector2.ZERO

const QUOTES = ["Temporal (Entrer)", 
			   "Frontal (Entrer)", 
			   "Pariétal (Entrer)", 
			   "Occipital (Entrer)", 
			   "Changer lettre",
			   "Non disponible"]

var state = State.NORMAL
var color = Colors.DEFAULT

signal change_it

var transitionReversed = false

func _physics_process(delta):
	var axis = Vector2.ZERO
	axis.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	axis.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	axis = axis.normalized()
	
	if axis.x != 0 || axis.y != 0:
		motion = (motion + axis * ACCELERATION).clamped(MAX_SPEED)
		if $Visage.get_animation() == "idle": 
			$Visage.play("starting")
			transitionReversed = false
	else:
		motion = motion.linear_interpolate(Vector2.ZERO, 0.05)
		if $Visage.get_animation() == "swimming": 
			$Visage.play("starting", true)
			transitionReversed = true
		motion = motion.linear_interpolate(Vector2.ZERO, 0.01)
	
	$Particles.get_process_material().set_gravity(Vector3(motion.x * -1, motion.y * -1, 0)) 
	move_and_slide(motion)

func _input(event):
	if event.is_action_pressed("ui_accept"):
		if state == State.TEMPORAL:
			get_tree().change_scene("res://scenes/Levels/Temporal.tscn")
		if state == State.FRONTAL:
			get_tree().change_scene("res://scenes/Levels/Frontal.tscn")
		if state == State.OCCIPITAL:
			get_tree().change_scene("res://scenes/Levels/Occipital.tscn")
		if state == State.PARIETAL:
			get_tree().change_scene("res://scenes/Levels/Parietal.tscn")
		if state == State.LETTER:
			emit_signal("change_it")
			
	if event.is_action_pressed("Color_DEFAULT"):
		color = Colors.DEFAULT
	if event.is_action_pressed("Color_PURPLE"):
		color = Colors.PURPLE
	if event.is_action_pressed("Color_GREEN"):
		color = Colors.GREEN
	if event.is_action_pressed("Color_BLUE"):
		color = Colors.BLUE
	if event.is_action_pressed("Color_PINK"):
		color = Colors.PINK
		
# --- ON TOP PLAYER'S POP UP --- #

func _process(delta):
	var modulateColor = Colors.POOL[color]
	
	$Visage.modulate = modulateColor
	$Particles.modulate = modulateColor
	
	if state == State.NORMAL:
		$Top_pop_up.set_visible(false)
	else:
		$Top_pop_up.set_visible(true)
		$Top_pop_up/Label.set_text(QUOTES[state-1])
		$Top_pop_up/Sprite.set_visible(state == State.INCAPACITATE)
		
func _on_Temporal_body_entered(body):
	if body == self:
		state = State.TEMPORAL

func _on_Temporal_body_exited(body):
	if state == State.TEMPORAL and body == self:
		state = State.NORMAL

func _on_Frontal_body_entered(body):
	if body == self:
		state = State.FRONTAL

func _on_Frontal_body_exited(body):
	if state == State.FRONTAL and body == self:
		state = State.NORMAL

func _on_Parietal_body_entered(body):
	if body == self:
		state = State.PARIETAL

func _on_Parietal_body_exited(body):
	if state == State.PARIETAL and body == self:
		state = State.NORMAL

func _on_Occipital_body_entered(body):
	if body == self:
		state = State.OCCIPITAL

func _on_Occipital_body_exited(body):
	if state == State.OCCIPITAL and body == self:
		state = State.NORMAL

func _on_Center_body_entered(body):
	if body == self:
		state = State.INCAPACITATE
	
func _on_Center_body_exited(body):
	if state == State.INCAPACITATE:
		state = State.NORMAL

#-- LETTER INTERACTION --#

# TODO

# -- MOB INTERACTIONS -- #

func playerCheckColor(foe):
	if color == foe.color:
		foe.queue_free()
	else:
		print("t mor")
		
func _on_Visage_animation_finished():
	if $Visage.get_animation() == "starting" and not transitionReversed: $Visage.play("swimming")
	elif $Visage.get_animation() == "starting" : $Visage.play("idle")




