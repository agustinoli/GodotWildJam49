extends Node2D

export (String, FILE, "*.tscn") var Return_Scene: String

func _ready():
	var config = ConfigFile.new()
	var err = config.load("res://config.cfg")
	var cant_lines = 2

	if err != OK:
		return

	$CanvasLayer/Label.text = str(tr("CREDITS"), "\n\n")
	for credit in config.get_section_keys("credits"):
		cant_lines += 1
		$CanvasLayer/Label.text += str(tr(credit), " ", tr("BY"), " ", config.get_value("credits", credit), "\n")
	
	# Workaround for not exceding the screen
	if cant_lines > 6:
		$CanvasLayer/Label.get_font("font").size -= cant_lines - 6

func _input(event):
	if event is InputEventKey and event.pressed:
		Game.emit_signal("ChangeScene", Return_Scene)
