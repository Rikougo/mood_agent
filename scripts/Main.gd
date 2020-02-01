extends Node

const mainMenu = preload("res://scenes/MainMenu.tscn")

const hub = preload("res://scenes/Levels/Hub.tscn")

const occipital = preload("res://scenes/Levels/Occipital.tscn")
const temporal = preload("res://scenes/Levels/Temporal.tscn")
const frontal = preload("res://scenes/Levels/Frontal.tscn")
const parietal = preload("res://scenes/Levels/Parietal.tscn")

# const endLevel = preload()
# const winScreen = preload()

const HUB_ANIMATIONS = [
	"open_occipital",
	"open_temporal",
	"open_frontal",
	"open_parietal",
	"open_center"
	]

var currentScene

var levelCompleted = 0

func _ready():
	changeScene(mainMenu)
	
func changeScene(scene: PackedScene):
	if currentScene:
		remove_child(currentScene)
		
	currentScene = scene.instance()
	add_child(currentScene)
	
func startGame():
	changeScene(hub)
	
	currentScene.get_node("Structures/AnimatedSprite").play(HUB_ANIMATIONS[levelCompleted])

func onOccipitalCompleted():
	levelCompleted = max(levelCompleted, 1)
	changeScene(hub)
	
	currentScene.get_node("Structures/AnimatedSprite").play(HUB_ANIMATIONS[levelCompleted])
	
func onTemporalCompleted():
	levelCompleted = max(levelCompleted, 2)
	changeScene(hub)
	
func onFrontalCompleted():
	levelCompleted = max(levelCompleted, 3)
	changeScene(hub)
	
func onParietalCompleted():
	levelCompleted = max(levelCompleted, 4)
	changeScene(hub)
	
#func onEnding():
	#changeScene(winScreen)
