extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var required_text


var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	required_text = "Value"+str(rng.randi_range(100,999))
	$Target.set_text(required_text)

func _unhandled_input(event):
	var user_input = $UserInput.get_text()
	if event.is_pressed() and event.scancode == KEY_BACKSPACE:
		user_input.erase(user_input.length()-1,1)
		$UserInput.set_text(user_input)
	elif event.is_pressed() and (event.scancode == KEY_ENTER or event.scancode == KEY_KP_ENTER):
		if user_input == $Target.get_text():
			print("ganaste")
		else:
			print("algo esta mal")
	elif event.is_pressed():
		$UserInput.set_text(user_input+ char(event.unicode))
