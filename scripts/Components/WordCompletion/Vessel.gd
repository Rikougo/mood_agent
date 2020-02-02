extends Area2D

export var text = ""
signal full

func _on_Receptacle_body_entered(body):
	print(body, body.name)
	if body.name.begins_with("Mot") and body.current == 1 and body.WORDS[1] == text:
		body.set_position(position - Vector2(0,30))
		body.set_deferred("mode",1)
		body.get_node("CollisionShape2D").set_deferred("disabled", true)
		emit_signal("full")
