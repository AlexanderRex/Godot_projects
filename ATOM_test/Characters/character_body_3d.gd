extends CharacterBody3D

# Speeds for keys 1-4
var speeds = [4, 7, 10, 14] # Adjust these values as needed

# The downward acceleration when in the air, in meters per second squared.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var current_speed_index = 0 # Start with the first speed
var target_velocity = Vector3.ZERO

# This function is called every physics frame (default is 60 times per second)
func _physics_process(delta):
	var direction = Vector3.ZERO

	# Check for inputs to change speed
	# We iterate through the possible keys (1-4)
	# If a key is pressed, we update the current speed index
	for i in range(4):
		if Input.is_key_pressed(i + KEY_1):
			current_speed_index = i

	# Check for inputs to change direction
	# We move the cube in the direction indicated by the input
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_back"):
		direction.z += 1
	if Input.is_action_pressed("move_forward"):
		direction.z -= 1

	# If we have some direction, we normalize the direction vector 
	# And then set the cube's direction to face the direction of movement
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		$Pivot.look_at(position + direction, Vector3.UP)

	# Update our target velocity based on our direction and current speed
	# If we are moving, we want to move at the speed indicated by the current speed index
	target_velocity.x = direction.x * speeds[current_speed_index]
	target_velocity.z = direction.z * speeds[current_speed_index]

	# If we are not on the floor, we apply a downward acceleration (simulating gravity)
	if not is_on_floor():
		target_velocity.y = target_velocity.y - (gravity * delta)

	# We update the character's velocity and move the character
	velocity = target_velocity
	move_and_slide()
