extends RigidBody2D

const Colors = preload("res://scripts/Global/Colors.gd")

signal touch

export var min_speed = 150  # Minimum speed range.
export var max_speed = 250  # Maximum speed range.
var color = int(rand_range(1.0, 5.0))

var player
var velocity

func init(_player):
	player = _player

func _ready():
	modulate = Colors.POOL[color]
	$Light2D.set_color(Colors.POOL[color])

func _process(delta):
	velocity = Vector2.ZERO
	if player:
		#velocity = (player.position - position).normalized() * 1000
		velocity = lerp(position, player.position, 0.5)
	

func _on_Mob_body_entered(_body):
	emit_signal("touch")
