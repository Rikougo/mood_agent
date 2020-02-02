extends Node

const MAIN_MENU = "res://scenes/MainMenu.tscn"

const HUB = "res://scenes/Levels/Hub.tscn"

const OCCIPITAL = "res://scenes/Levels/Occipital.tscn"
const TEMPORAL = "res://scenes/Levels/Temporal.tscn"
const FRONTAL = "res://scenes/Levels/Frontal.tscn"
const PARIETAL = "res://scenes/Levels/Parietal.tscn"

# const endLevel = preload()
# const winScreen = preload()

var loader
var wait_frames
var time_max = 100 # msec
var current_scene
var current_path

var levelCompleted = 0

func _input(event):
	if event.is_action_pressed("ui_select"):
		goto_scene(current_scene.PATH)
	if event.is_action_pressed("reset_hard"):
		levelCompleted = 0
		goto_scene(HUB)

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() -1)

func goto_scene(path): # game requests to switch to this scene
	loader = ResourceLoader.load_interactive(path)
	if loader == null: # check for errors
		print("err loader null")
		return
	set_process(true)

	current_path = path
	current_scene.queue_free() # get rid of the old scene

func _process(time):
	if loader == null:
		# no need to process anymore
		set_process(false)
		return

	var t = OS.get_ticks_msec()
	while OS.get_ticks_msec() < t + time_max: # use "time_max" to control for how long we block this thread

		# poll your loader
		var err = loader.poll()

		if err == ERR_FILE_EOF: # Finished loading.
			var resource = loader.get_resource()
			loader = null
			set_new_scene(resource)
			break
		elif err == OK:
			update_progress()
		else: # error during loading
			print("Err process")
			loader = null
			break
			
func update_progress():
	pass

func set_new_scene(scene_resource):
	
	current_scene = scene_resource.instance()
	get_node("/root").add_child(current_scene)

func on_level_completed(level):
	levelCompleted = max(levelCompleted, level + 1)
	goto_scene(HUB)
