extends KinematicBody2D

const GRAVITY = 900
 
var walk_speed = 100

var direction = Vector2.ZERO


func _process(delta):
	direction.y += GRAVITY * delta
	
	if is_on_floor():
		direction.x = walk_speed
	
	direction = move_and_slide(direction  ,  Vector2.UP)


func _ready():
	pass # Replace with function body.


