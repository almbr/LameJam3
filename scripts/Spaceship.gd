extends RigidBody

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	thrust = Vector3()
	torque = Vector3()
	parse_input(delta)
	add_central_force(thrust)
	#add_central_force_local(thrust)
	add_torque(torque)
	
	# Parent follow child
	#set_translation(hull.get_global_transform().origin)

export var side_thrusters_torqe = Vector3(0,100,0)
export var forward_thrust = 100
export var reverse_thrust = -50
export var side_thruster_impulse = 40

var thrust = Vector3()
var torque = Vector3()
	
func thruster(thruster):
	# Thrust
	if (thruster == "forward") && (thruster == "reverse"):
		thrust = Vector3()
	elif thruster == "forward":
		thrust = transform.basis.z * forward_thrust
		#translate_object_local(-transform.basis.z)
	elif thruster == "reverse":
		thrust = transform.basis.z * reverse_thrust
		#ranslate_object_local(transform.basis.z)
		
	# Rotation
	if (thruster == "left") && (thruster == "right"):
		torque = Vector3()
	elif thruster == "left":
		torque = side_thrusters_torqe
	elif thruster == "right": 
		torque = side_thrusters_torqe * Vector3(1,-1,1)

func parse_input(delta):
	if Input.is_action_pressed("Fire"):
		print("fire")
		pass #fire()
	if Input.is_action_pressed("ui_up"):
		thruster("forward")
	elif Input.is_action_pressed("ui_down"):
		thruster("reverse")
	if Input.is_action_pressed("ui_left"):
		#hull.rotate_object_local(Vector3(0, 1, 0), delta)
		thruster("left")
	if Input.is_action_pressed("ui_right"):
		#hull.rotate_object_local(Vector3(0, -1, 0), delta)
		thruster("right")

#func _input(event):
#	if event.is_action_pressed("Left_side"):
#		hull.apply_central_impulse(Vector3(side_thruster_impulse,1,1)*hull.transform.basis.x)
#	if event.is_action_pressed("Right_side"):
#		hull.apply_central_impulse(Vector3(-side_thruster_impulse,1,1))
