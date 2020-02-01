extends Area2D

var ID = get_filename().substr(0, get_filename().length())
const ANIMATION = ["A", "B", "C", "D"]
var current = 0
var test = self

func _on_KinematicBody2D_change_it():
	print(test)
	current = (current + 1) % ANIMATION.size()
	$AnimatedSprite.play(ANIMATION[current])
	get_parent().get_node("Node").roundup(ID, ANIMATION[current])
