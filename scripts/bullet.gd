extends Node2D

export (float) var dist = 1000.0
export (float) var damage = 1.0

var end

func _ready():
	end = Vector2(dist, 0)
	$Ray.force_raycast_update()
	if $Ray.is_colliding():
		var _end = to_local($Ray.get_collision_point())
		if _end.length() > dist:
			return
		end = _end
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
