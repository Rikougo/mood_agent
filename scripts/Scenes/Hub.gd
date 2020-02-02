extends Node2D

var AREAS

const HUB_ANIMATIONS = [
	"open_occipital",
	"open_temporal",
	"open_frontal",
	"open_parietal",
	"open_center"
	]

onready var game = get_node("/root/Game")

func _ready():
	AREAS = [
		get_node("Node2D/Occipital"),
		get_node("Node2D/Temporal"),
		get_node("Node2D/Frontal"),
		get_node("Node2D/Parietal"),
		get_node("Node2D/Center")
	]
	
	var frame = $Structures/AnimatedSprite.frame
	var anim  = $Structures/AnimatedSprite.animation
	var scale = $Structures/AnimatedSprite.scale
	
	var size = $Structures/AnimatedSprite.get_sprite_frames().get_frame(anim, frame).get_size() * scale
	
	$Player.set_camera_limit(Rect2(- size.x / 2, - size.y / 2, size.x, size.y))
	
	for i in range(game.levelCompleted + 1):
		AREAS[i].get_node("CollisionPolygon2D").set_disabled(false)
		
	$Structures/AnimatedSprite.play(HUB_ANIMATIONS[game.levelCompleted])

func _on_Player_enterSlowMode():
	$ColorRect.material.set_shader_param("u_colorFactor", 0.1)

func _on_Player_exitSlowMode():
	$ColorRect.material.set_shader_param("u_colorFactor", 1.0)
