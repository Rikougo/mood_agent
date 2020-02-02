extends Area2D

func _on_Transform_body_entered(body):
	if body.name.begins_with("Mot"):
		body._update()
