extends Node2D


export (int) var nbullets = 1
export (float) var spread = 0.1
export (float) var cooldown = 1


var can_shoot = true



func shoot():
	if not can_shoot:
		return
	can_shoot = false
	
	for i in range(nbullets):
		var bullet = $Muzzle.create_bullet()
		bullet.global_transform = $Muzzle.global_transform
		bullet.rotation += (randf() * 2 - 1) * spread
		get_node("/root").add_child(bullet)
	
	yield(get_tree().create_timer(cooldown), "timeout")
	can_shoot = true
