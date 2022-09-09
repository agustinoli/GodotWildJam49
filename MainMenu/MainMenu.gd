extends CanvasLayer

export (String, FILE, "*.tscn") var First_Level: String

onready var playerName = $BG/MarginContainer/VBoxMain/HBoxContainer/VBoxContainer/PlayerName
onready var LoginButton = $BG/MarginContainer/VBoxMain/HBoxContainer/VBoxContainer/Login
onready var RegisterButton = $BG/MarginContainer/VBoxMain/HBoxContainer/VBoxContainer/Register
const welcome_tag = "WELCOME"

func _ready()->void:
	#Godot doesn't have buttons auto grab_focus when noone has focus
	get_tree().get_nodes_in_group("MainMenu")[0].grab_focus()
	MenuEvent.connect("Options", self, "on_options")
	
	if OS.get_name() == "HTML5":
		$"BG/MarginContainer/VBoxMain/HBoxContainer/ButtonContainer/Exit".visible = false
	#Localization
	SettingsLanguage.connect("ReTranslate", self, "retranslate")
	retranslate()
	# Login
	if SilentWolf.Auth.logged_in_player != null:
		LoginButton.set_text(tr("LOGOUT"))
		RegisterButton.set_disabled(true)
		playerName.set_text(tr(welcome_tag)+" "+str(SilentWolf.Auth.logged_in_player))
	else:
		LoginButton.set_text(tr("LOGIN"))
		RegisterButton.set_disabled(false)
		playerName.set_text("")
	

func on_options(value:bool)->void:
	if !value && !MenuEvent.Paused:
		get_tree().get_nodes_in_group("MainMenu")[0].grab_focus()

func _on_NewGame_pressed()->void:
	Game.emit_signal("NewGame")
	Game.emit_signal("ChangeScene", First_Level)

func _on_Options_pressed()->void:
	MenuEvent.Options = true

func _on_Exit_pressed()->void:
	Game.emit_signal("Exit")

#Localization
func retranslate()->void:
	find_node("NewGame").text = tr("NEW_GAME")
	find_node("Leaderboard").text = tr("LEADERBOARD")
	find_node("Login").text = tr("LOGIN")
	find_node("Register").text = tr("REGISTER")
	find_node("Credits").text = tr("CREDITS")
	find_node("Options").text = tr("OPTIONS")
	find_node("Exit").text = tr("EXIT")

func _on_Leaderboard_pressed():
	Game.emit_signal("ChangeScene", "res://Leaderboard/Leaderboard.tscn")


func _on_Login_pressed():
	
	if SilentWolf.Auth.logged_in_player != null:
		SilentWolf.Auth.logout_player()
		Game.emit_signal("ChangeScene", "res://MainMenu/MainMenu.tscn")
	else:
		Game.emit_signal("ChangeScene", "res://Auth/Login.tscn")


func _on_Register_pressed():
	Game.emit_signal("ChangeScene", "res://Auth/Register.tscn")


func _on_Credits_pressed():
	Game.emit_signal("ChangeScene", "res://addons/GameTemplate/CreditsScreen/CreditsScreen.tscn")
