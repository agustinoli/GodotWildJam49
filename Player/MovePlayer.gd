extends State
# MOVEMENT FROM:
# 	https://godotengine.org/qa/31522/how-to-apply-sprite-for-8-direction-movement

onready var player = self.get_node('../../')
onready var animationSprite = self.get_node('../../AnimatedSprite')
onready var timer


func _ready():
	timer = Timer.new()
	timer.set_one_shot(false)
	timer.set_wait_time(1)
	add_child(timer)
	timer.start()
	timer.set_paused(true)

# Virtual function. Receives events from the `_unhandled_input()` callback.
func handle_input(_event: InputEvent) -> void:
	pass


# Virtual function. Corresponds to the `_process()` callback.
func fsm_update(_delta: float) -> void:
	player.parse_input()
	if !Input.is_action_pressed("Left") and !Input.is_action_pressed("Up") and !Input.is_action_pressed("Right") and !Input.is_action_pressed("Down"):
		state_machine.transition_to("Idle")


# Virtual function. Corresponds to the `_physics_process()` callback.
func physics_update(_delta: float) -> void:
	if player.log_active:
		return
		
	var move_direction = Vector2()

	var LEFT = Input.is_action_pressed("Left")
	var RIGHT = Input.is_action_pressed("Right")
	var UP = Input.is_action_pressed("Up")
	var DOWN = Input.is_action_pressed("Down")
	
	if Game.switched:
		move_direction.x = -int(RIGHT) + int(LEFT)
		move_direction.y = -int(DOWN) + int(UP)
	else:
		move_direction.x = int(RIGHT) - int(LEFT)
		move_direction.y = int(DOWN) - int(UP)
	# Si va en diagonal, velocidad vertical disminuida
	if move_direction.x != 0 and move_direction.y != 0:
		move_direction.y /= 2

	if LEFT || RIGHT || UP || DOWN:
		player.set_facing(move_direction)
	
	player.set_current_dir(direction2str(player.facing))
	
	player.collision = player.move_and_collide(move_direction * player.speed)
	
	var animation = player.get_current_dir()
	if animationSprite.get_animation() != animation:
		animationSprite.play(animation)

func direction2str(direction):
	var angle = direction.angle()
	if angle < 0:
		angle += 2 * PI
	var index = round(angle / PI * 4)
	return player.get_dir(index)

# Virtual function. Called by the state machine upon changing the active state. The `msg` parameter
# is a dictionary with arbitrary data the state can use to initialize itself.
func enter(_msg := {}) -> void:
	timer.set_paused(false)	
	player.get_audio_stream().play()

# Virtual function. Called by the state machine before changing the active state. Use this function
# to clean up the state.
func exit() -> void:
	timer.set_paused(true)	
	player.get_audio_stream().stop()


