extends NavigationPolygonInstance


func add_shape(outline):
	for i in range(1, navpoly.get_outline_count()):
		var oldline = navpoly.get_outline(i)
		var intersect = Geometry.intersect_polygons_2d(outline, oldline)
		if not intersect.empty():
			var union = Geometry.merge_polygons_2d(outline, oldline)
			for poly in union:
				if not Geometry.is_polygon_clockwise(poly):
					poly.invert()
					navpoly.set_outline(i, poly)
					return
		
	navpoly.add_outline(outline)


func update():
	navpoly.clear_polygons()
	navpoly.make_polygons_from_outlines()
	enabled = false
	enabled = true
