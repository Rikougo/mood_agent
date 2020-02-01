extends Node

export (PackedScene) var Mob
export (NodePath) var playerPath

onready var player = get_node(playerPath)

func _on_NewWave_timeout():
	$WavePath/WaveSpawn.set_offset(randi())
	var mob = Mob.instance()
	add_child(mob)
	mob.connect("touch", mob.get_parent(), "checkColor", [mob])
	var direction = $WavePath/WaveSpawn.rotation + PI / 2
	mob.position = $WavePath/WaveSpawn.position
	direction += rand_range(-PI / 4, PI / 4)
	mob.rotation = direction
	mob.linear_velocity = Vector2(rand_range(mob.min_speed, mob.max_speed), 0)
	mob.linear_velocity = mob.linear_velocity.rotated(direction)

func checkColor(arg):
	player.playerCheckColor(arg)
