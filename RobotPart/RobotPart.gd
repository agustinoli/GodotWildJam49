extends Area2D

onready var player_inside = false
var timer


func _ready():
	timer = GlobalTimer.add_timeout(self, "modulate_sprite", 0.5, false, false)
	$Label.text = ""


func _process(_delta):
	if player_inside and Input.is_action_just_pressed("ui_accept"):
		GlobalTimer.delete_timeout(timer)
		Game.on_robot_part_picked(self.get_name())
		self.disconnect("body_exited", self, "_on_RobotPart_body_exited") # Debido a un bugsito
		queue_free()


func _on_RobotPart_body_entered(body):
	if body.get_name() == "Player":
		GlobalTimer.start_timeout(timer)
		player_inside = true
		$Label.text = tr("PICK-ROBOT-PART")


func _on_RobotPart_body_exited(body):
	if body.get_name() == "Player":
		GlobalTimer.stop_timeout(timer)
		$Area2D/Sprite.modulate.a = 1
		player_inside = false
		$Label.text = ""


func modulate_sprite():
	if $Area2D/Sprite.modulate.a == 1:
		$Area2D/Sprite.modulate.a = 0.7
	else:
		$Area2D/Sprite.modulate.a = 1
