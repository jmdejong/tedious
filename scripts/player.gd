extends KinematicBody2D


export var speed = 100

var weapons
var weaponidx = 0

func _ready():
	weapons = $Weapons.get_children()
	for weapon in weapons:
		$Weapons.remove_child(weapon)
	arm(0)

func arm(idx):
	var hand = $Body/Hand
	for child in hand.get_children():
		child.stop_shooting()
		hand.remove_child(child)
	var weapon = weapons[idx]
	weaponidx = idx
	hand.add_child(weapon)

func select(idx, relative=false):
	if relative:
		idx = (idx + weaponidx + weapons.size()) % weapons.size()
	if idx < weapons.size():
		arm(idx)

func _input(event):
	if event.is_action_pressed("fire"):
		var weapon = $Body/Hand.get_child(0)
		weapon.start_shooting()
	if event.is_action_released("fire"):
		var weapon = $Body/Hand.get_child(0)
		weapon.stop_shooting()
	if event.is_action_pressed("next_weapon"):
		select(1, true)
	if event.is_action_pressed("previous_weapon"):
		select(-1, true)

func _physics_process(delta):
	var velocity = Vector2()
	velocity.x = int(Input.is_action_pressed('right')) - int(Input.is_action_pressed('left'))
	velocity.y = int(Input.is_action_pressed('down')) - int(Input.is_action_pressed('up'))
	velocity *= speed
	var mouse_position = get_global_mouse_position()
	$Body.look_at(mouse_position)
	velocity = move_and_slide(velocity)
