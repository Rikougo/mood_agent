extends Node2D

var lastOpened = 0

const PATH = "res://scenes/Levels/Occipital.tscn"

onready var game = get_node("/root/Game")

func _ready():
	var frame = $Structures/AnimatedSprite.frame
	var anim  = $Structures/AnimatedSprite.animation
	var scale = $Structures/AnimatedSprite.scale
	
	var size = $Structures/AnimatedSprite.get_sprite_frames().get_frame(anim, frame).get_size() * scale
	
	$Player.set_camera_limit(Rect2(- size.x / 2, - size.y / 2, size.x, size.y))
	
	$Structures/AnimatedSprite.set_animation("firstZone")
	$Structures/AnimatedSprite.set_frame(0)
	$Structures/AnimatedSprite.stop()

func _on_Player_enterSlowMode():
	$ColorRect.material.set_shader_param("u_colorFactor", 0.1)
	
func _on_Player_exitSlowMode():
	$ColorRect.material.set_shader_param("u_colorFactor", 1.0)

func _on_EndPoint_body_entered(body):
	if body == $Player:
		game.on_level_completed(Levels.OCCIPITAL)

func _firstHole_full():
	if lastOpened == 0:
		$Structures/AnimatedSprite.play("firstZone")
		$Structures/GateOne.queue_free()
		$Structures/Occluders/GateOne.queue_free()
		lastOpened = 1
		
func _secondHole_full():
	if lastOpened == 1:
		$Structures/AnimatedSprite.play("secondZone")
		$Structures/GateTwo.queue_free()
		$Structures/Occluders/GateTwo.queue_free()
		lastOpened = 2
		
func _thirdHole_full():
	if lastOpened == 2:
		$Structures/AnimatedSprite.play("thirdZone")
		$Structures/GateThree.queue_free()
		$Structures/Occluders/GateThree.queue_free()
		lastOpened = 3

var lastHole_one = false
var lastHole_two = false

func _lastHoleOne_full(): 
	print(lastHole_two)
	lastHole_one = true
	if lastHole_two: _lastHole_full()
	
func _lastHoleTwo_full():
	print(lastHole_one)
	lastHole_two = true
	if lastHole_one: _lastHole_full()
		
func _lastHole_full():
	$Structures/AnimatedSprite.play("lastZone")
	$Structures/GateFour.queue_free()
	$Structures/Occluders/GateFour.queue_free()
