extends Node2D
onready var game = get_node("/root/Game")

const PATH = "res://scenes/Levels/Temporal.tscn"

func _ready():
	var frame = $Structures/AnimatedSprite.frame
	var anim  = $Structures/AnimatedSprite.animation
	var scale = $Structures/AnimatedSprite.scale
	
	var size = $Structures/AnimatedSprite.get_sprite_frames().get_frame(anim, frame).get_size() * scale
	
	$Player.set_camera_limit(Rect2(- size.x / 2, - size.y / 2, size.x, size.y))
	
	$Structures/AnimatedSprite.set_animation("firstGate")
	$Structures/AnimatedSprite.set_frame(0)
	$Structures/AnimatedSprite.stop()

func _on_Player_enterSlowMode():
	print("t")
	$ColorRect.material.set_shader_param("u_colorFactor", 0.1)
	
func _on_Player_exitSlowMode():
	$ColorRect.material.set_shader_param("u_colorFactor", 1.0)

func _wordOne_completed():
	$Structures/AnimatedSprite.play("firstGate")
	$Structures/GateOne.queue_free()
	
func _wordTwo_completed():
	$Structures/AnimatedSprite.play("secondGate")
	$Structures/GateTwo.queue_free()
	
func _wordThree_completed():
	$Structures/AnimatedSprite.play("lastGate")
	$Structures/GateThree.queue_free()
