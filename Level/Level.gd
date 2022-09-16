extends Node2D

export (String, FILE, "*.tscn") var Next_Scene: String
var timer

func _ready()->void:
	timer = GlobalTimer.add_timeout(self,"time_over",30)
	Hud.set_timer(str(int(timer.get_time_left())))
	Hud.visible = true
	PauseMenu.can_show = true	
	var t_shake 	= GlobalTimer.add_timeout(self,"activate_shake",1,false)
	var t_blackout 	= GlobalTimer.add_timeout(self,"activate_blackout",1,true)
	var t_switch 	= GlobalTimer.add_timeout(self,"activate_switch",1,false)

func _exit_tree()->void:
	Hud.visible = false
	PauseMenu.can_show = false


func _process(_delta):
	Hud.set_timer(str(int(timer.get_time_left())))

func activate_shake():
	GlobalTimer.add_timeout(self,"activate_shake",rand_range(1,10),true)
	print("shake: ",OS.get_time())


func activate_blackout():
	GlobalTimer.add_timeout(self,"activate_blackout",rand_range(1,10),true)
	$Player.blackout()
	print("blackout: ",OS.get_time())


func activate_switch():
	GlobalTimer.add_timeout(self,"activate_switch",rand_range(1,10),true)
	print("switch: ",OS.get_time())


func time_over():	
	Game.emit_signal("ChangeScene",select_ending())


func select_ending()-> String:
#	Calculates proper ending given the parameters 
#	and returns the string to the packedscene
	return "res://MainMenu/MainMenu.tscn"
