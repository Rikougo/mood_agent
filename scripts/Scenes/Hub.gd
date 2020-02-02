extends Node2D

var AREAS

func _ready():
	AREAS = [
		get_node("Node2D/Occipital"),
		get_node("Node2D/Frontal"),
		get_node("Node2D/Parietal"),
		get_node("Node2D/Temporal"),
		get_node("Node2D/Center")
	]
	
func openGates(levelCompleted):
	for i in range(levelCompleted+1):
		AREAS[i].get_node("CollisionPolygon2D").set_disabled(false)

func _on_Player_enterSlowMode():
	$ColorRect.material.set_shader_param("u_colorFactor", 0.1)


func _on_Player_exitSlowMode():
	$ColorRect.material.set_shader_param("u_colorFactor", 1.0)
