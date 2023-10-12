extends Camera3D

var radius = 45.0
var angularSpeed = 30.0 # Degrees per second
var currentAngle = 0.0

func _ready():
	pass

func _process(delta):
	# Update the current angle based on angular speed and time
	currentAngle += angularSpeed * delta

	# Calculate the new position on the circle
	var x = radius * sin(deg_to_rad(currentAngle))
	var z = radius * cos(deg_to_rad(currentAngle))

	# Update the camera's position
	transform.origin.x = x
	transform.origin.z = z

	# Make the camera always look at the origin (0, 0, 0)
	look_at(Vector3(0, 0, 0), Vector3(0, -1, 0))
