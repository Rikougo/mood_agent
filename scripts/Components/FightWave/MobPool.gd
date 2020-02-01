extends Node

export (PackedScene) var Mob
export (NodePath) var playerPath

onready var player = get_node(playerPath)

func _on_NewWave_timeout():
	$WavePath/WaveSpawn.set_offset(randi())
	var mob = Mob.instance()
	add_child(mob)
	mob.init(player)
	mob.connect("touch", mob.get_parent(), "checkColor", [mob])
	var direction = $WavePath/WaveSpawn.rotation + PI / 2
	mob.position = $WavePath/WaveSpawn.position
	direction += rand_range(-PI / 4, PI / 4)
	mob.rotation = direction

func checkColor(arg):
	player.playerCheckColor(arg)
