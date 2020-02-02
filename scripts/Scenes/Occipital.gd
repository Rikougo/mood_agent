extends Node2D

var lastOpened = 0

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

func _input(event):
	if event.is_action_pressed("ui_select"):
		openNext()

func _on_Player_enterSlowMode():
	$ColorRect.material.set_shader_param("u_colorFactor", 0.1)
	
func _on_Player_exitSlowMode():
	$ColorRect.material.set_shader_param("u_colorFactor", 1.0)

func openNext():
	if lastOpened == 0:
		$Structures/AnimatedSprite.play("firstZone")
		$Structures/GateOne.queue_free()
		$Structures/Occluders/GateOne.queue_free()
		lastOpened = 1
	elif lastOpened == 1:
		$Structures/AnimatedSprite.play("secondZone")
		$Structures/GateTwo.queue_free()
		$Structures/Occluders/GateTwo.queue_free()
		lastOpened = 2
	elif lastOpened == 2:
		$Structures/AnimatedSprite.play("thirdZone")
		$Structures/GateThree.queue_free()
		$Structures/Occluders/GateThree.queue_free()
		lastOpened = 3
	elif lastOpened == 3:
		$Structures/AnimatedSprite.play("lastZone")
		$Structures/GateFour.queue_free()
		$Structures/Occluders/GateFour.queue_free()
		lastOpened = 4


func _on_EndPoint_body_entered(body):
	if body == $Player:
		game.on_level_completed(Levels.OCCIPITAL)
