extends Node2D

export (float) var dist = 1000.0
export (float) var damage = 1.0
export (float) var width = 1
export (Color) var color = Color("#222")

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
	draw_rect(Rect2(Vector2(0, -width/2), end + Vector2(0, width)), color)

func _on_Timer_timeout():
	queue_free()
