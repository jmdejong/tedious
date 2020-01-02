extends KinematicBody2D


export var speed = 100
export (PackedScene) var Bullet



func _input(event):
	if event.is_action_pressed("fire"):
		var bullet = Bullet.instance()
		bullet.global_transform = $Head/Muzzle.global_transform
		get_node("/root").add_child(bullet)

func _physics_process(delta):
	var velocity = Vector2()
	velocity.x = int(Input.is_action_pressed('right')) - int(Input.is_action_pressed('left'))
	velocity.y = int(Input.is_action_pressed('down')) - int(Input.is_action_pressed('up'))
	velocity *= speed
	var mouse_position = get_global_mouse_position()
	get_node("Head").look_at(mouse_position)
	velocity = move_and_slide(velocity)
