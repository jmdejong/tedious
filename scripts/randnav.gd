extends Node2D

export var radius = 12
export var cell_size = 1000

export var xmin = -100000
export var ymin = -100000
export var xmax = 100000
export var ymax = 100000

var astar = AStar2D.new()
var cells = {}


func add_point(point):
	var cell = Vector2(int(point.x / cell_size), int(point.y / cell_size))
	if not cells.had(cell):
		cells[cell] = PoolVector2Array()
	cells[cell].append(point)
	var id = astar.get_available_point_id()
	astar.add_point(id, point)
	return id

func test_connection(a, b):
	$Rays.global_position = a
	$Rays.global_rotation = b.angle_to_point(a)
	$Rays.global_scale = Vector2(a.distance_to(b), radius)
# 	print("ray testing")
	update()
	for ray in $Rays.get_children():
		ray.force_raycast_update()
		if ray.is_colliding():
			return false
	return true

func _draw():
# 	print("draw ray testing")
	for ray in $Rays.get_children():
# 		print(ray.global_position)
		draw_line(ray.to_global(Vector2(0, 0)), ray.to_global(ray.cast_to), Color(1,0,0))

func find_route(start, end):
	if test_connection(start, end):
		return PoolVector2Array([end])
	
	return PoolVector2Array()

func get_simple_path(start, end):
	return find_route(start, end)
# 	add_point(start)
# 	add_point(end)
