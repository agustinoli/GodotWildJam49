extends Node

onready var audio:AudioStreamPlayer = $AudioStreamPlayer
onready var audio2:AudioStreamPlayer = $AudioStreamPlayer2
onready var current_player: AudioStreamPlayer = audio
var next_player

export var transition_duration = 5

func _ready():
	current_player = audio
	current_player.set_stream(load("res://Assets/Music/Menu.ogg"))
	current_player.play()

func play(new_track:String)->void:
	if current_player == audio:
		next_player = audio2
	else:
		next_player = audio
	next_player.set_stream(load(new_track))
	$Tween.interpolate_property(current_player,"volume_db",0,-80,
		transition_duration,Tween.TRANS_LINEAR, Tween.EASE_OUT, 0)
	$Tween.interpolate_property(next_player,"volume_db",-80,0,
		transition_duration, Tween.TRANS_LINEAR, Tween.EASE_IN, 0)
	$Tween.start()
	next_player.play()


func _on_Tween_tween_all_completed():
	current_player.stop() #stop the one lowered
	current_player = next_player #change the reference
