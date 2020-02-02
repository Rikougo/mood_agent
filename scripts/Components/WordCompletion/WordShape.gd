extends CollisionShape2D

var hitBox = RectangleShape2D.new()
var dimension = Vector2()

func _update(length):
	dimension = get_parent().get_node("Label").get_size()
	dimension.x = length * 20
	dimension.y = dimension.y - 50
	hitBox.set_extents(dimension)
	set_shape(hitBox)
