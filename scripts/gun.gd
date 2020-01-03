extends Node2D


export (PackedScene) var Bullet
export (int) var nbullets = 1
export (float) var spread = 0.1
export (float) var distance = 1000
export (float) var distance_spread = 0.25
export (float) var damage = 1


func shoot():
	
	var min_distance = distance * (1 - distance_spread)
	
	for i in range(nbullets):
		var bullet = Bullet.instance()
		bullet.dist = distance * (1 - distance_spread + 2 * distance_spread * randf())
		bullet.global_transform = $Muzzle.global_transform
		bullet.rotation += (randf() * 2 - 1) * spread
		get_node("/root").add_child(bullet)
