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


func _on_KillArea_body_entered(body):
	if body.is_in_group("player"):
		get_tree().reload_current_scene()


func _on_DieArea_body_entered(body):
	if body.is_in_group("player"):
		GlobalSignal.emit_signal("push_up")
		queue_free()




func _on_DieArea_area_entered(area):
	if area.is_in_group("ufo"):
		GlobalSignal.emit_signal("ufo_return")
		queue_free()
		
		
	if area.is_in_group("player_weapon"):
		queue_free()
		
		
		
		
		
		
		
		
		
		
		
		
