extends Area2D

onready var player_inside = false
var key_name
var timer


func _ready():
	key_name = InputMap.get_action_list("ui_accept")[0].as_text()
	timer = GlobalTimer.add_timeout(self, "modulate_sprite", 0.5, false, false)
	$AudioStreamPlayer2D.set_stream(load("res://Assets/Sounds/Sparks.wav"))
	$Label.text = ""
	$Area2D/Sprite.texture = load(str("res://Assets/Images/RobotParts/", self.get_name(), ".png"))
	$Area2D/Sprite.scale = Vector2(2, 2)
	$AudioStreamPlayer2D.connect("finished",self,"on_audio_finished")
	$AudioStreamPlayer2D.play()


func _process(_delta):
	if player_inside and Input.is_action_just_pressed("ui_accept"):
		GlobalTimer.delete_timeout(timer)
		get_parent().get_parent().part_picked()
		self.disconnect("body_exited", self, "_on_RobotPart_body_exited") # Debido a un bugsito
		queue_free()


func _on_RobotPart_body_entered(body):
	if body.get_name() == "Player":
		GlobalTimer.start_timeout(timer)
		player_inside = true
		$Label.text = str(tr("PRESS"), " ", key_name)


func _on_RobotPart_body_exited(body):
	if body.get_name() == "Player":
		GlobalTimer.stop_timeout(timer)
		$Area2D/Sprite.modulate.a = 1
		player_inside = false
		$Label.text = ""


func on_audio_finished():
	timer = GlobalTimer.add_timeout(self,"restart_audio",rand_range(1,10))
	

func restart_audio():
	$AudioStreamPlayer2D.play()


func modulate_sprite():
	if $Area2D/Sprite.modulate.a == 1:
		$Area2D/Sprite.modulate.a = 0.7
	else:
		$Area2D/Sprite.modulate.a = 1
