extends Area2D





# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.





func _on_Power_up_body_entered(body):
	GlobalSignal.emit_signal("power_up")
	queue_free()
