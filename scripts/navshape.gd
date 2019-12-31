extends NavigationPolygonInstance

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export (PoolVector2Array) var navigation_shape = PoolVector2Array()


# Called when the node enters the scene tree for the first time.
func _ready():
	var worldnav = get_node("/root/main/Nav/WorldNav")
	print("NAVPOLY")
	#print("shape: ", navigation_shape)
	print("outline count: ", navpoly.get_outline_count())
	#print("outlines")
	for i in range(navpoly.get_outline_count()):
		var outline = PoolVector2Array()
		for v in navpoly.get_outline(i):
			outline.push_back(worldnav.to_local(to_global(v)))
		print("    ", outline)
		worldnav.navpoly.add_outline(outline)
	
	worldnav.navpoly.clear_polygons()
	worldnav.navpoly.make_polygons_from_outlines()
	worldnav.enabled = false
	worldnav.enabled = true
	#print("polygon count: ", navpoly.get_polygon_count())
	#print("polygons")
	#for i in range(navpoly.get_polygon_count()):
		#print("    ", navpoly.get_polygon(i))
	#print("vertices: ", navpoly.get_vertices())
	
	for i in range(worldnav.navpoly.get_outline_count()):
		print("wol ", worldnav.navpoly.get_outline(i))
	
	print("NAVPOLY_END")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
