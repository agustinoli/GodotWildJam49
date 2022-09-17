extends Node2D

export (String, FILE, "*.tscn") var Next_Scene: String

func _ready()->void:
	Hud.visible = true
	PauseMenu.can_show = true	
	var t_shake 	= GlobalTimer.add_timeout(self,"activate_shake",1,false)
	var t_blackout 	= GlobalTimer.add_timeout(self,"activate_blackout",1,true)
	var t_switch 	= GlobalTimer.add_timeout(self,"activate_switch",1,false)

func _exit_tree()->void:
	Hud.visible = false
	PauseMenu.can_show = false


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


func part_picked():
	$Player.next_log()
