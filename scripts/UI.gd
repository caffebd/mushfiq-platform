extends Control

var score_count = 0

var countDown_timer = 30

func _ready():
	GlobalSignal.connect("change_score" , self, "_change_score")
	$Timer.start()





func _change_score():
	score_count += 1
	$Label.text = "Gold :" + str(score_count)








func _on_Timer_timeout():
	countDown_timer -= 1
	$TimerLabel.text = "Time :" +str(countDown_timer)
	if countDown_timer == 0:
		$Timer.stop()
