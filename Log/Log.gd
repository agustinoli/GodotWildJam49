extends Node2D

onready var hold = false
var timer

func _ready():
	self.visible = false
	timer = GlobalTimer.add_timeout(self, "dehold", 3, false, true)
	find_node("Exit").text = ""


func _input(event):
	if not hold and event.is_pressed():
		self.visible = false
		self.get_parent().log_active = false
		Hud.set_visible(true)
		find_node("Exit").text = ""
		
		if Game.picked_logs == 7:
			get_parent().get_parent().get_parent().time_over()


func init():
	self.get_parent().log_active = true
	hold = true
	find_node("Message").text = tr("LOG-INIT")
	find_node("Title").text = tr("LOG-INIT-TITLE")
	self.visible = true
	GlobalTimer.start_timeout(timer)
	Hud.set_visible(false)


func next():
	self.get_parent().log_active = true
	Game.picked_logs += 1
	Hud.set_parts(Game.picked_logs)
	SfxManager.play("Piece"+str(Game.picked_logs))
	hold = true
	find_node("Message").text = tr(str("LOG-", Game.picked_logs))
	find_node("Title").text = tr("LOG-TITLE")
	self.visible = true
	Hud.set_visible(false)
	GlobalTimer.start_timeout(timer)


func dehold():
	hold = false
	find_node("Exit").text = tr("LOG-EXIT")
