extends Node2D

export (float) var distance = 1000.0
export (float) var distance_spread = 0.25
export (float) var damage = 1.0
export (float) var width = 1
export (Color) var color = Color("#222")

var end
var dist

func _ready():
	dist = distance * (1 - distance_spread + 2 * distance_spread * randf())
	end = Vector2(dist, 0)
	$Ray.set_cast_to(end)
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
	draw_rect(Rect2(Vector2(0, -width/2), end + Vector2(0, width)), color)

func _on_Timer_timeout():
	queue_free()
