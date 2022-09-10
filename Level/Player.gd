extends KinematicBody2D


func _ready():
	pass # Replace with function body.


func _physics_process(_delta: float) -> void:
	var move_direction = Vector2()

	var LEFT = Input.is_action_pressed("Left")
	var RIGHT = Input.is_action_pressed("Right")
	var UP = Input.is_action_pressed("Up")
	var DOWN = Input.is_action_pressed("Down")

	move_direction.x = int(RIGHT) - int(LEFT)
	move_direction.y = int(DOWN) - int(UP)
	
	# Si va en diagonal, velocidad vertical disminuida
	if move_direction.x != 0 and move_direction.y != 0:
		move_direction.y /= 2

	move_and_collide(move_direction * 2)
