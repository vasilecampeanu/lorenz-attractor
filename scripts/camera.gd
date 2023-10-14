extends Camera3D

var radius = 45.0
var angularSpeed = 30.0
var currentAngle = 0.0

func _ready():
	pass

func _process(delta):
	currentAngle += angularSpeed * delta

	var x = radius * sin(deg_to_rad(currentAngle))
	var z = radius * cos(deg_to_rad(currentAngle))

	transform.origin.x = x
	transform.origin.z = z

	look_at(Vector3(0, 0, 0), Vector3(0, -1, 0))
