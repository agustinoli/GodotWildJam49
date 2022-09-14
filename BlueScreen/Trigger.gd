extends Sprite

onready var blueScreenScene : PackedScene = load ("res://BlueScreen/BlueScreen.tscn")


func _on_Area2D_body_entered(body):
	if body is Player:
		print_debug("Entro player")
		var bsod = blueScreenScene.instance()
		bsod.set_position(body.get_position())
		bsod.set_player(body)
		body.set_recursive_process_input(false)
		self.get_tree().get_current_scene().add_child(bsod)
		queue_free()
