extends Node2D


export var enabled = true

var outlines = []


func _ready():
	if not enabled:
		return
	var worldnav = get_node("/root/main/Nav/WorldNav")
	var walls = $Walls
	var ts = walls.tile_set
	var shapes = {}
	var transform = walls.cell_custom_transform.affine_inverse()
	var tssize = ts.autotile_get_size(0)
	var invscale = Vector2(1/tssize.x, 1/tssize.y)
# 	print(ts.autotile_get_size(0))
	for sd in ts.tile_get_shapes(0):
		shapes[sd["autotile_coord"]] = sd
	for cell in walls.get_used_cells():
		var coord = walls.get_cell_autotile_coord(cell.x, cell.y)
# 		print("------CELL: ", coord)
# 		print(shapes[coord])
		var shape = shapes[coord]["shape"].points
		var trans = Transform2D().scaled(invscale).scaled(walls.cell_size).translated(cell * walls.cell_size)
# 		print(trans)
		var a = trans.xform(shape)
# 		print("AAA: ",a)
		var outline = walls.global_transform.xform(a)
# 		for v in shape:
# 			var c = coord + v * ts.autotile_get_size(0)
# 			print(c)
# 			outline.push_back(worldnav.to_local(transform.xform(c)))
# 		print("outline: ", outline)
		var navshape = Geometry.offset_polygon_2d(outline, worldnav.nav_width)[0]
# 		print("navshape: ", navshape)
		outlines.append(navshape)
		worldnav.add_shape(navshape)
	update()
	worldnav.update()
# 	print("invscale: ", invscale)
# 	print("nav transform: ", worldnav.to_local(Vector2(1, 1)))
# 		print(ts.tile_get_shapes(id))


# func _draw():
# 	print("draw house outline")
# 	draw_polyline(PoolVector2Array([Vector2(-200,0), Vector2(200,0), Vector2(0,-200), Vector2(0,200)]), Color(1, 1, 0))
# 	for line in outlines:
# 		var outline = global_transform.xform_inv(line)
# 		print("drawline: ", outline)
# 		var color = Color(randf(), randf(), randf())
# 		for i in range(outline.size() - 1):
# 			draw_line(outline[i], outline[i+1], color)
# 		draw_line(outline[outline.size()-1], outline[0], color)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
