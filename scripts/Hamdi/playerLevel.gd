extends KinematicBody2D

const FLOOR = Vector2(0,-1)
const ACC = 50
const MAX_SPEED   = 200
const GRAVITY = 20
const JUMP = -600
const DASH = 1000

var jump_count = 1
var on_ground = false
var vel = Vector2()

func _ready():
	pass
	
func _physics_process(delta):
	var reset = Input.is_action_just_pressed("ui_accept")
	var right1 = Input.is_action_pressed("ui_right")
	var right2 = Input.is_action_just_released("ui_right")
	var left1 = Input.is_action_pressed("ui_left")
	var left2 = Input.is_action_just_released("ui_left")
	var jump = Input.is_action_just_pressed("ui_up")
	var dash = Input.is_action_just_pressed("ui_A") 
	
	
	var friction = false
	
	vel.y += GRAVITY 
	if reset :
		position = Vector2(448,384)
		
	if right1 :
		vel.x = min(vel.x+ACC, MAX_SPEED)
	elif left1 : 
		vel.x = max(vel.x-ACC, -MAX_SPEED)
	else : 
		friction = true
	
	if jump :
		if jump_count<2:	
			vel.y = JUMP
			jump_count +=1
	
	if is_on_floor() : 
		on_ground = true
		jump_count = 1
			
		if friction :
			vel.x = lerp(vel.x, 0, 0.2)
	else : 
		on_ground = false
		if friction :
			vel.x = lerp(vel.x, 0, 0.010)
		
	vel = move_and_slide(vel, FLOOR)




