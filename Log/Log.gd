extends Node2D

onready var message_index = 0
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
		find_node("Exit").text = ""


func init():
	self.get_parent().log_active = true
	hold = true
	find_node("Message").text = tr("LOG-INIT")
	find_node("Title").text = tr("LOG-INIT-TITLE")
	self.visible = true
	GlobalTimer.start_timeout(timer)


func next():
	self.get_parent().log_active = true
	message_index += 1
	hold = true
	find_node("Message").text = tr(str("LOG-", message_index))
	find_node("Title").text = tr("LOG-TITLE")
	self.visible = true
	GlobalTimer.start_timeout(timer)


func dehold():
	hold = false
	find_node("Exit").text = tr("LOG-EXIT")
