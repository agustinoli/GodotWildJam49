extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_NewScore_pressed():
	var player_name
	if SilentWolf.Auth.logged_in_player != null:
		player_name = SilentWolf.Auth.logged_in_player
	else:
		player_name = "Anonimous player"
	
	var score = 420
	var ldboard_name = "main"
	var metadata = {
		"elapsed_time_ms": 231457,
		"won_boss_fight": true
	}
	SilentWolf.Scores.persist_score(player_name, score, ldboard_name, metadata)

func _on_ResetScene_pressed():
	PauseMenu.can_show = false
	Game.emit_signal("ChangeScene", "res://addons/silent_wolf/Tests/LeaderboardTest.tscn")
