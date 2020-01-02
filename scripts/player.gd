extends KinematicBody2D


export var speed = 100



func _input(event):
	if event.is_action_pressed("fire"):
		$Head/Gun.shoot()

func _physics_process(delta):
	var velocity = Vector2()
	velocity.x = int(Input.is_action_pressed('right')) - int(Input.is_action_pressed('left'))
	velocity.y = int(Input.is_action_pressed('down')) - int(Input.is_action_pressed('up'))
	velocity *= speed
	var mouse_position = get_global_mouse_position()
	get_node("Head").look_at(mouse_position)
	velocity = move_and_slide(velocity)
