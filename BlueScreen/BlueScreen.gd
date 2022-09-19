extends Node2D
class_name BSOD

var required_text
var rng = RandomNumberGenerator.new()
var player
export onready var PENALTY_TIME = 2.0

func _ready():
	$Camera2D._set_current(true)
	init()

func set_player(_player : Player):
	player = _player

func _unhandled_input(event):
	var user_input = $UserInput.get_text()
	if event.is_pressed() and event.scancode == KEY_BACKSPACE:
		user_input.erase(user_input.length()-1,1)
		$UserInput.set_text(user_input)
	elif event.is_pressed() and (event.scancode == KEY_ENTER or event.scancode == KEY_KP_ENTER):
		if user_input == $Target.get_text():
			good()
		else:
			bad()
	elif event.is_pressed():
		$UserInput.set_text(user_input+ char(event.unicode))

func init():
	rng.randomize()
	required_text = str(rng.randi_range(1, pow(10,Game.difficulty+2)-1 ) )
	$Target.set_text(required_text)
	self.set_process_unhandled_input(true)

func good():
	$Screen.set_self_modulate(Color(0,1,0,1))
	GlobalTimer.add_timeout(self,"timeout_on_good",PENALTY_TIME)

func bad():
	self.set_process_unhandled_input(false)	
	SfxManager.play("BSOD"+ str( randi()%6 + 1 ) )
	$Screen.set_self_modulate(Color(1,0,0,1))
	GlobalTimer.add_timeout(self,"timeout_on_bad",PENALTY_TIME * Game.difficulty)

func timeout_on_good():
	self.get_parent().remove_child(self)
	player.get_camera()._set_current(true)
	player.set_recursive_process_input(true)
	queue_free()

func timeout_on_bad():
	init()
	$UserInput.set_text("")
	$Screen.set_self_modulate(Color(1,1,1,1))
