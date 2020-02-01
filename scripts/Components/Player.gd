extends KinematicBody2D

const Colors = preload("res://scripts/Global/Colors.gd")

export (Vector2) var cameraDefault
export (Vector2) var cameraZoom
# export (NodePath) var canvasModPath

onready var canvasMod = get_node("../CanvasModulate")

enum State{
	NORMAL,
	TEMPORAL,
	FRONTAL,
	PARIETAL,
	OCCIPITAL,
	LETTER,
	INCAPACITATE,
	SLOW_MO
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

func _ready():
	$Color_Menu/C_up.modulate = Colors.POOL[Colors.BLUE]
	$Color_Menu/C_down.modulate = Colors.POOL[Colors.PINK]
	$Color_Menu/C_left.modulate = Colors.POOL[Colors.PURPLE]
	$Color_Menu/C_right.modulate = Colors.POOL[Colors.GREEN]
	
	

func _physics_process(delta):
	
	# --- PLAYER MOVEMENT --- #
	
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
	
	# ---- END PLAYER MOVEMENT ---- #

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
		
	# --- SLOW MO SWITCH --- #
		
	if Input.is_action_pressed("slow_mode"):
		state = State.SLOW_MO
		Engine.time_scale = 0.2
		
	if Input.is_action_just_released("slow_mode"):
		Engine.time_scale = 1
		if state == State.SLOW_MO:
			state = State.NORMAL

func _process(delta):
	var modulateColor = Colors.POOL[color]

	if state == State.SLOW_MO:
		if canvasMod:
			canvasMod.color = Color(0.3, 0.3, 0.3)
		$Camera2D.set_zoom($Camera2D.get_zoom().linear_interpolate(cameraZoom, 0.1))
		showColorWheel()
		
		var axis = Vector2.ZERO
		
		axis.x = Input.get_action_strength("Color_GREEN") - Input.get_action_strength("Color_PURPLE")
		axis.y = Input.get_action_strength("Color_PINK") - Input.get_action_strength("Color_BLUE")
		
		if(axis.length() > 0):
			if max(abs(axis.x), abs(axis.y)) == abs(axis.x):
				if sign(axis.x) == -1.0:
					color = Colors.PURPLE
				else:
					color = Colors.GREEN
			else:
				if sign(axis.y) == -1.0:
					color = Colors.BLUE
				else:
					color = Colors.PINK
					
		updateColorScale()
	else:
		if canvasMod:
			canvasMod.color = Color(0.35, 0.35, 0.35)
		$Camera2D.set_zoom($Camera2D.get_zoom().linear_interpolate(cameraDefault, 0.1))
		hideColorWheel()
	
	$Visage.modulate = modulateColor
	$Particles.modulate = modulateColor
	
	if state == State.NORMAL || state == State.SLOW_MO:
		$Top_pop_up.set_visible(false)
	else:
		$Top_pop_up.set_visible(true)
		$Top_pop_up/Label.set_text(QUOTES[state-1])
		$Top_pop_up/Sprite.set_visible(state == State.INCAPACITATE)
		
func _on_Temporal_body_entered(body):
	if state == State.NORMAL && body == self:
		state = State.TEMPORAL

func _on_Temporal_body_exited(body):
	if state == State.TEMPORAL and body == self:
		state = State.NORMAL

func _on_Frontal_body_entered(body):
	if state == State.NORMAL && body == self:
		state = State.FRONTAL

func _on_Frontal_body_exited(body):
	if state == State.FRONTAL and body == self:
		state = State.NORMAL

func _on_Parietal_body_entered(body):
	if state == State.NORMAL && body == self:
		state = State.PARIETAL

func _on_Parietal_body_exited(body):
	if state == State.PARIETAL and body == self:
		state = State.NORMAL

func _on_Occipital_body_entered(body):
	if state == State.NORMAL && body == self:
		state = State.OCCIPITAL

func _on_Occipital_body_exited(body):
	if state == State.OCCIPITAL and body == self:
		state = State.NORMAL

func _on_Center_body_entered(body):
	if state == State.NORMAL && body == self:
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

# -- COLOR WHEEL -- #
func showColorWheel():
	if !$Color_Menu.visible:
		$Color_Menu.set_visible(true)
			
func hideColorWheel():
	if $Color_Menu.visible:
		$Color_Menu.set_visible(false)

func updateColorScale():
	$Color_Menu/C_left.scale  = Vector2(1, 1)
	$Color_Menu/C_right.scale = Vector2(1, 1)
	$Color_Menu/C_up.scale    = Vector2(1, 1)
	$Color_Menu/C_down.scale  = Vector2(1, 1)
	
	if color == Colors.PURPLE:
		$Color_Menu/C_left.scale  *= 2
	elif color == Colors.GREEN:
		$Color_Menu/C_right.scale *= 2
	elif color == Colors.BLUE:
		$Color_Menu/C_up.scale    *= 2
	elif color == Colors.PINK:
		$Color_Menu/C_down.scale  *= 2
