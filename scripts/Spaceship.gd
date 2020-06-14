extends RigidBody

var is_master = false

func initialize(id):
	name = str(id)
	if id == Net.net_id:
		is_master = true
	#else:
	#	modulate = Color8(255, 0, 0, 255)
	

func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	if is_master:
		thrust = Vector3()
		torque = Vector3()
		parse_input(delta)
		add_central_force(thrust)
		add_torque(torque)
		rpc_unreliable("update_translation", translation)
		
remote func update_translation(tran):
	translation = tran

export var side_thrusters_torqe = Vector3(0,100,0)
export var forward_thrust = 100
export var reverse_thrust = -50
export var side_thruster_impulse = 60

var thrust = Vector3()
var torque = Vector3()
	
func thruster(thruster):
	# Thrust
	if (thruster == "forward") && (thruster == "reverse"):
		thrust = Vector3()
	elif thruster == "forward":
		thrust = transform.basis.z * forward_thrust
	elif thruster == "reverse":
		thrust = transform.basis.z * reverse_thrust
		
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
		thruster("left")
	if Input.is_action_pressed("ui_right"):
		thruster("right")

func _input(event):
	if event.is_action_pressed("Left_side"):
		apply_central_impulse(transform.basis.x*side_thruster_impulse)
	if event.is_action_pressed("Right_side"):
		apply_central_impulse(-transform.basis.x*side_thruster_impulse)
