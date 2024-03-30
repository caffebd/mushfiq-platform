extends Control

var score_count = 0

var Power_time = 10 

var countDown_timer = 30

func _ready():
	GlobalSignal.connect("change_score" , self, "_change_score")
	$Timer.start()
	GlobalSignal.connect("power_up" , self, "_power_up")
	

func _power_up():
	$Power_Timer.start()




func _change_score():
	score_count += 1
	$Label.text = "Gold :" + str(score_count)



func _on_Power_Timer_timeout():
	Power_time -= 1
	$Power_Lable.text = "PFT :" +str(Power_time)
	if Power_time == 0:
		$Power_Timer.stop()





func _on_Timer_timeout():
	countDown_timer -= 1
	$TimerLabel.text = "Time :" +str(countDown_timer)
	if countDown_timer == 0:
		$Timer.stop()
  


