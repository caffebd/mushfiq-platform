extends KinematicBody2D

const GRAVITY = 900
 
var walk_speed = 100

var direction = Vector2.ZERO

export var walk_time = 3


func _ready():
	$WalkTimer.wait_time = walk_time



func _process(delta):
	direction.y += GRAVITY * delta
	
	if is_on_floor():
		direction.x = walk_speed
	
	direction = move_and_slide(direction  ,  Vector2.UP)




func _on_WalkTimer_timeout():
	walk_speed *= -1
