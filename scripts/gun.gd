extends Node2D


export (PackedScene) var Bullet


func shoot():
	var bullet = Bullet.instance()
	bullet.global_transform = $Muzzle.global_transform
	get_node("/root").add_child(bullet)
