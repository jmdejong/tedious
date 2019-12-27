extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var speed = 4000
export (PackedScene) var Bullet

# Called when the node enters the scene tree for the first time.
#func _ready():
	#pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _input(event):
	if event.is_action_pressed("fire"):
		#var raycast = get_node("Head/Muzzle/RayCast2D")
		#print(raycast)
		#print(raycast.get_collider())
		var bullet = Bullet.instance()
		bullet.global_transform = $Head/Muzzle.global_transform
		get_node("/root").add_child(bullet)

func _physics_process(delta):
	var velocity = Vector2()
	velocity.x = int(Input.is_action_pressed('right')) - int(Input.is_action_pressed('left'))
	velocity.y = int(Input.is_action_pressed('down')) - int(Input.is_action_pressed('up'))
	velocity *= speed*delta
	var mouse_position = get_global_mouse_position()
	get_node("Head").look_at(mouse_position)
	velocity = move_and_slide(velocity)
