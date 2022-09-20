extends Node

export (String, FILE, "*.tscn") var next_scene: String

onready var index = 0
var timer


func _ready():
	timer = GlobalTimer.add_timeout(self, "next_msg", 10, true, false)


func _input(event):
	if event.is_pressed():
		if next_msg():
			return
		timer.stop()
		timer.start()


func next_msg():
	index += 1
	var trans_key = str("INTRO-", index)
	var trans_val = tr(trans_key)
	
	if trans_key == trans_val:
		GlobalTimer.delete_timeout(timer)
		Game.emit_signal("ChangeScene",next_scene)
		return true
	else:
		$Message.text = trans_val
		return false

