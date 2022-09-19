extends Sprite

onready var blueScreenScene : PackedScene = load ("res://BlueScreen/BlueScreen.tscn")


func _on_Area2D_body_entered(body):
	if body is Player:
		var bsod = blueScreenScene.instance()
		SfxManager.play("BSOD"+ str( randi()%6 + 1 ) )
		bsod.set_position(body.get_position())
		bsod.set_player(body)
		body.set_recursive_process_input(false)
		self.get_tree().get_current_scene().add_child(bsod)
		queue_free()
