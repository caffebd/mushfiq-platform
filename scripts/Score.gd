extends Area2D





func _on_Score_body_entered(body):
	GlobalSignal.emit_signal("change_score")
	queue_free()
