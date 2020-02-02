extends Area2D

const Colors = preload("res://scripts/Global/Colors.gd")
export var color = Colors.PURPLE

func _ready():
	modulate = Colors.POOL[color]

func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies :
		if body.name.begins_with("CBlock"):
			body.queue_free()
			$sprite.visible = 1
			modulate = Colors.POOL[body.color]
