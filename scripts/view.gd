extends Camera2D

export var target_zoom = 1
export var max_zoom = 8
export var min_zoom = 0.5
export var zoom_step = sqrt(sqrt(2))
export var zoom_speed = 8

#var actual_zoom = target_zoom

func _ready():
	zoom = Vector2(target_zoom, target_zoom)

func change_zoom(change):
	target_zoom *= change
	target_zoom = clamp(target_zoom, min_zoom, max_zoom)

func zoom_out():
	change_zoom(zoom_step)

func zoom_in():
	change_zoom(1/zoom_step)

func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			# zoom in
			if event.button_index == BUTTON_WHEEL_UP:
				change_zoom(1.414)
			if event.button_index == BUTTON_WHEEL_DOWN:
				change_zoom(0.707)
	if Input.is_action_pressed('zoom_out'):
		zoom_out()
	elif Input.is_action_pressed('zoom_in'):
		zoom_in()
	
func _process(delta):
	zoom = zoom.linear_interpolate(Vector2(target_zoom, target_zoom), delta * zoom_speed)
	#if actual_zoom != target_zoom:
		#actual_zoom = target_zoom
		#zoom = Vector2(actual_zoom, actual_zoom)
