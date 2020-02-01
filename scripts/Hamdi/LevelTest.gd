extends Node2D

const GRAVITY = 100



func _ready():
	pass 

func _process(delta):
	get_node("Player").yStrenght += GRAVITY * delta
	

