extends Area2D

const Colors = preload("res://scripts/Global/Colors.gd")

export var waitcolor = Colors.PURPLE
export var fill = 1
signal full

func _ready():
	modulate = Colors.POOL[waitcolor]
	
func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies :
		if body.name.begins_with("CBlock") and body.color == waitcolor and fill > 0:
			_found_it(body)

func _found_it(body):
	fill -= 1
	if fill <= 0:
		emit_signal("full")
		body.queue_free()
