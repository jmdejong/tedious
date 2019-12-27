extends KinematicBody2D


export var speed = 3500
export var sight_range = 500
export var attack_range = 20

enum Status {IDLE, APPROACH, ATTACK}
var status = Status.IDLE

func _physics_process(delta):
	var player = get_node_or_null("/root/main/Player")
	if player == null:
		status = Status.IDLE
	
	if status == Status.IDLE:
		if player and position.distance_to(player.position) < sight_range:
			status = Status.APPROACH
	
	if status == Status.APPROACH:
		if position.distance_to(player.position) < attack_range:
			status = Status.ATTACK
		else:
			look_at(player.position)
			var velocity = (player.position - position).normalized() * speed
			move_and_slide(velocity * delta)
	
	if status == Status.ATTACK:
		if position.distance_to(player.position) > attack_range:
			status = status.APPROACH
	
