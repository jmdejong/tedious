extends NavigationPolygonInstance

export var nav_width = 14.9
export var min_dist = 0.4
export var min_dot = -0.99

var count = 0

func getm(vec, id):
	id = id % vec.size()
	if id < 0:
		id += vec.size()
	return vec[id]

func overlaps(a, b):
	var intersect = Geometry.intersect_polygons_2d(a, b)
# 	print(intersect)
	return not intersect.empty()

func merge_overlapping(a, b):
	var union = Geometry.merge_polygons_2d(a, b)
	for poly in union:
		if not Geometry.is_polygon_clockwise(poly):
			poly.invert()
			return poly
	assert(false)

func add_shape(outline):
	var i=1
	while i < navpoly.get_outline_count():
		var other = navpoly.get_outline(i)
		if not overlaps(outline, other) and Geometry.merge_polygons_2d(outline, other).size() == 1:
			print("TOUCHING!!!!!!!!!!!!!")
# 		print(overlaps(outline, other), Geometry.merge_polygons_2d(outline, other).size())
		if overlaps(outline, other):
# 			print("overlap ", i, " ", outline, other)
# 			print("")
			outline = merge_overlapping(outline, other)
			navpoly.remove_outline(i)
		else:
			i += 1
	var j = 0
	while j < outline.size():
		var a = getm(outline, j-1)
		var b = outline[j]
		var c = getm(outline, j+1)
		if a.distance_to(b) < min_dist or b.distance_to(c) < min_dist:
			outline.remove(j)
			continue
		var x = (a - b).normalized()
		var y = (c - b).normalized()
		var dotp = x.dot(y)
# 		print(dotp, " ", a, b, c)
		if dotp < min_dot:
			outline.remove(j)
		else:
			j += 1
	navpoly.add_outline(outline)
	
# 	print("outlines: ", navpoly.get_outline_count())
# 	for i in range(1, navpoly.get_outline_count()):
# 		var oldline = navpoly.get_outline(i)
# 		if overlaps(outline, oldline):
# 			var merged = merge_overlapping(outline, oldline)
# 			navpoly.set_outline(i, merged)
# 			return
# 		
# 	navpoly.add_outline(outline)


func update():
	print("update ", count)
	for i in range(1, navpoly.get_outline_count()):
		var pl = navpoly.get_outline(i)
		if not Geometry.is_polygon_clockwise(pl):
# 			print("counter clockwise poly! ", i)
			pl.invert()
			navpoly.set_outline(i, pl)
		for j in range(i+1, navpoly.get_outline_count()):
			if overlaps(navpoly.get_outline(i), navpoly.get_outline(j)):
				print("forbidden overlap! ", i, " ", j)
	count += 1
	navpoly.clear_polygons()
	navpoly.make_polygons_from_outlines()
	enabled = false
	enabled = true
	.update()

func _draw():
	for i in range(0, navpoly.get_outline_count()):
		var outline = navpoly.get_outline(i)
		var color = Color(1, 0.2, 0)#float(i) / (navpoly.get_outline_count() - 1), 0.5, 0)
		for i in range(outline.size()):
			draw_line(outline[i], outline[(i+1)%outline.size()], color)
			draw_circle(outline[i], 2, Color(1, 0, 1))
# 		draw_line(outline[outline.size()-1], outline[0], color)
