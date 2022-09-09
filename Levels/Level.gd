extends Node2D

export (String, FILE, "*.tscn") var Next_Scene: String

func _ready()->void:
	Hud.visible = true
	PauseMenu.can_show = true

func _on_Button_pressed()->void:
	PauseMenu.can_show = false
	Game.emit_signal("ChangeScene", Next_Scene)

func _exit_tree()->void:
	Hud.visible = false
	PauseMenu.can_show = false


func _on_TestGlobalTimer_pressed():
	PauseMenu.can_show = false
	Game.emit_signal("ChangeScene", "res://addons/GameTemplate/Tests/GlobalTimerTest.tscn")


func _on_TestEnv_pressed():
	PauseMenu.can_show = false
	Game.emit_signal("ChangeScene", "res://addons/GameTemplate/Tests/DotEnvTest.tscn")


func _on_TestHighScore_pressed():
	PauseMenu.can_show = false
	Game.emit_signal("ChangeScene", "res://addons/silent_wolf/Tests/LeaderboardTest.tscn")
