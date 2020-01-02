extends KinematicBody2D


export var speed = 80
export var sight_range = 500
export var attack_range = 20

enum Status {IDLE, APPROACH, ATTACK}
var status = Status.IDLE
var path = PoolVector2Array()

var threshold = 4

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
			if path.size() == 0:
				var nav = get_node("/root/main/Nav")
				path = nav.get_simple_path(position, player.position)
			else:
				follow_path(delta)
			
	
	if status == Status.ATTACK:
		if position.distance_to(player.position) > attack_range:
			status = status.APPROACH
	
func follow_path(delta):
	

	var point = path[0]
	var velocity = (point - position).normalized() * speed
	if position.distance_to(point) < speed * delta:
		path.remove(0)
		if path.size() > 0:
			point = path[0]
		else:
			return
	
	
	look_at(point)
	move_and_slide(velocity)
	


