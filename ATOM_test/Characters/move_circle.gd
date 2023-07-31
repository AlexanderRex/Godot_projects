extends CharacterBody3D

var speed = 2.0
var radius = 2.0
var angle = 0.0

func _physics_process(delta):
	angle += speed * delta

	var new_pos = Vector3()
	new_pos.x = radius * cos(angle)
	new_pos.y = 0
	new_pos.z = radius * sin(angle)

	# Устанавливаем высоту по оси Z равную 0.5
	new_pos.y += 0.5

	global_transform.origin = new_pos
