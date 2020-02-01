extends Node

const CORRECT = ['A', 'A', 'A']
var current = ['X', 'X', 'X']
var done = false

func ready():
	get_parent().get_node("Cell").hide()

func _physics_process(delta):
	if done :
		get_parent().get_node("Cell").show()
		
func roundup(id, letter):
	print(id)
	current[id] = letter
	done = check()

func check():
	for i in range(current.size()):
		if CORRECT[i] != current[i] :
			return false
	return true
