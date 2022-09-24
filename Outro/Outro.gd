extends Node

export (String, FILE, "*.tscn") var next_scene: String

onready var index = 0
var timer
var badness

func _ready():
	timer = GlobalTimer.add_timeout(self, "next_msg", 10, true, false)
	
	match self.get_name():
		"VeryGoodOutro":
			find_node("Player").play("default")
			badness = 0
		"GoodOutro":
			badness = 1
		"BadOutro":
			badness = 2
		"VeryBadOutro":
			find_node("ColorRect").modulate.a = 0.5
			badness = 3


func _input(event):
	if event.is_pressed():
		if next_msg():
			return
		timer.stop()
		timer.start()


func next_msg():
	index += 1
	var trans_key = str("OUTRO", badness, "-", index)
	var trans_val = tr(trans_key)
	
	if trans_key == trans_val:
		GlobalTimer.delete_timeout(timer)
		Game.emit_signal("ChangeScene",next_scene)
		return true
	else:
		find_node("Message").text = trans_val
		return false

