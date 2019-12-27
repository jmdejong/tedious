extends Node2D

export var dist = 1000
export var damage = 1

var end = Vector2(dist, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	$Ray.force_raycast_update()
	if $Ray.is_colliding():
		end = to_local($Ray.get_collision_point())
		attack($Ray.get_collider())

func attack(node):
	var health = node.get_node_or_null("Health")
	if not health:
		return
	health.damage(damage)


func _draw():
	draw_line(Vector2(0, 0), end, Color("#222"))

func _on_Timer_timeout():
	queue_free()
