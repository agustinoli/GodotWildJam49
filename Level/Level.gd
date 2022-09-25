extends Node2D

export (String, FILE, "*.tscn") var Next_Scene: String
const PLAY_TIME = 240
var timer
 
func _ready()->void:
	timer = GlobalTimer.add_timeout(self,"time_over", PLAY_TIME)
	Hud.set_timer(str(int(timer.get_time_left())))
	Hud.set_visible(false)
	PauseMenu.can_show = true	
	var t_shake 	= GlobalTimer.add_timeout(self,"activate_shake",1,false)
	var t_blackout 	= GlobalTimer.add_timeout(self,"activate_blackout",1,false)
	var t_switch 	= GlobalTimer.add_timeout(self,"activate_switch",1,false)
	Music.play("res://Assets/Music/Gameplay.ogg")

func _exit_tree()->void:
	Hud.visible = false
	PauseMenu.can_show = false


func _process(_delta):
	Hud.set_timer(str(int(timer.get_time_left())))


func activate_shake():
	GlobalTimer.add_timeout(self,"activate_shake",rand_range(1,10),true)


func activate_blackout():
	GlobalTimer.add_timeout(self,"activate_blackout",rand_range(1,10),true)
	find_node("Player").blackout()
	SfxManager.play("Blind")


func activate_switch():
	GlobalTimer.add_timeout(self,"activate_switch",rand_range(1,10),false)
	Game.switched = !Game.switched
	SfxManager.play("SwitchControls")	


func time_over():
	GlobalTimer.stop_timeout(timer)
	Game.emit_signal("ChangeScene",select_ending())


func select_ending()-> String:
	match Game.picked_logs:
		7:
			return "res://Outro/VeryGoodOutro.tscn"
		6:
			return "res://Outro/GoodOutro.tscn"
		5:
			return "res://Outro/GoodOutro.tscn"
		4:
			return "res://Outro/GoodOutro.tscn"
		3:
			return "res://Outro/BadOutro.tscn"
		2:
			return "res://Outro/BadOutro.tscn"
		1:
			return "res://Outro/VeryBadOutro.tscn"
		0:
			return "res://Outro/VeryBadOutro.tscn"
	
	return "res://MainMenu/MainMenu.tscn"


func part_picked():
	find_node("Player").next_log()
	
