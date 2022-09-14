extends Node2D

export (String, FILE, "*.tscn") var Next_Scene: String

func _ready()->void:
	Hud.visible = true
	PauseMenu.can_show = true

func _exit_tree()->void:
	Hud.visible = false
	PauseMenu.can_show = false
