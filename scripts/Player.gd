extends KinematicBody2D

export var speed = 250



export var jump_speed = -450
var gravity = 900

var direction := Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalSignal.connect("power_up" , self, "_power_up")

func _input(event):
	
	direction.x = 0
	
	if Input.is_action_pressed("right"):
		direction.x += speed
		$PlayerAnim.flip_h = false
		
	if Input.is_action_pressed("jump"):
		direction.y -= speed
		
	if Input.is_action_pressed("down"):
		direction.y += speed
		
	if Input.is_action_pressed("left"):
		direction.x -= speed
		$PlayerAnim.flip_h = true




func _process(delta):
	
	direction.y += gravity * delta
#	if Input.is_action_just_pressed("jump"):
#		if is_on_floor():
#			direction.y = jump_speed	

	direction = move_and_slide(direction,  Vector2.UP)
 
func _power_up():
	pass


