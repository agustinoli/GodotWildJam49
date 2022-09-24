extends CanvasLayer

signal EndGame

var can_show: = false

onready var resume: = find_node("Resume")
onready var restart: = find_node("Restart")
onready var options: = find_node("Options")
onready var mainmenu: = find_node("MainMenu")
onready var exit: = find_node("Exit")

var MainMenu: = 'res://MainMenu/MainMenu.tscn'		# MainMenu scene when in levels

func _ready()->void:
	MenuEvent.Paused = false
	
	#Localization
	SettingsLanguage.connect("ReTranslate", self, "retranslate")
	resume.connect("pressed", self, "_on_Resume_pressed")
	restart.connect("pressed", self, "_on_Restart_pressed")
	options.connect("pressed", self, "_on_Options_pressed")
	mainmenu.connect("pressed", self, "_on_MainMenu_pressed")
	exit.connect("pressed", self, "_on_Exit_pressed")
	retranslate()
	

func show_pause_menu(value:bool)->void:
	if !can_show:
		return
	MenuEvent.Paused = value
	$Control.visible = value
	Music.play("res://Assets/Music/Menu.ogg")
	if value:
		get_tree().get_nodes_in_group("Pause")[0].grab_focus()


func _on_Resume_pressed()->void:
	Game.emit_signal("Resume")
	show_pause_menu(false)

func _on_Restart_pressed()->void:
	Game.emit_signal("Restart")
	Music.play("res://Assets/Music/Gameplay.ogg")
	show_pause_menu(false)

func _on_Options_pressed()->void:
	MenuEvent.Options = true

func _on_MainMenu_pressed()->void:
	Game.emit_signal("ChangeScene", MainMenu)
	show_pause_menu(false)
	PauseMenu.can_show = false
	emit_signal("EndGame")

func _on_Exit_pressed()->void:
	Game.emit_signal("Exit")

func retranslate()->void:
	resume.text = tr("RESUME")
	restart.text = tr("RESTART")
	options.text = tr("OPTIONS")
	mainmenu.text = tr("MAIN_MENU")
	exit.text = tr("EXIT")



