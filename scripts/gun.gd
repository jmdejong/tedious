extends Node2D


export (PackedScene) var Bullet
export (int) var nbullets = 1
export (float) var spread = 0.1


func shoot():
	
	
	for i in range(nbullets):
		var bullet = Bullet.instance()
		bullet.global_transform = $Muzzle.global_transform
		bullet.rotation += (randf() * 2 - 1) * spread
		get_node("/root").add_child(bullet)
