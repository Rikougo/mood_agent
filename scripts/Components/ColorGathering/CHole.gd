extends Area2D

export var score =0

func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	
	for body in bodies:
		if body is RigidBody2D:
			body.hide()
