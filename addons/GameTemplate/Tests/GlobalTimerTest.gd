extends Node2D

var timer


func _ready():
	$CanvasLayer/AddButton.connect("pressed", self, "add_timeout")
	$CanvasLayer/StartButton.connect("pressed", self, "start_timeout")
	$CanvasLayer/StopButton.connect("pressed", self, "stop_timeout")
	$CanvasLayer/DeleteButton.connect("pressed", self, "delete_timeout")


func add_timeout():
	timer = GlobalTimer.add_timeout(self, "print_text", 
		$CanvasLayer/WhiteBack/TimeInput.value, 
		$CanvasLayer/WhiteBack/AutoStartInput.pressed, 
		$CanvasLayer/WhiteBack/OneshotInput.pressed)


func start_timeout():
	GlobalTimer.start_timeout(timer)


func stop_timeout():
	GlobalTimer.stop_timeout(timer)


func delete_timeout():
	GlobalTimer.delete_timeout(timer)


func print_text():
	print($CanvasLayer/WhiteBack/TextInput.text)
