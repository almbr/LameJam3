extends Camera

export var height = 200
var distance = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(true)
	set_as_toplevel(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var target = get_parent().get_global_transform().origin
	#var pos = get_global_transform().origin
	var up = Vector3(0,1,0)

	var offset = Vector3(0, height, 0) #pos - target
	var pos = target + offset
	
	set_global_transform( \
	Transform(get_parent().get_global_transform().basis, \
	target))
