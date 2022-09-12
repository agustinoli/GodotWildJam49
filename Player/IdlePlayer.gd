extends State

onready var player = self.get_node('../../')
onready var animationSprite = self.get_node('../../AnimatedSprite')
var ghost


# Virtual function. Receives events from the `_unhandled_input()` callback.
func handle_input(_event: InputEvent) -> void:
	pass


# Virtual function. Corresponds to the `_process()` callback.
func fsm_update(_delta: float) -> void:
	if Input.is_action_pressed("Left") or Input.is_action_pressed("Up") \
		or Input.is_action_pressed("Right") or Input.is_action_pressed("Down"):
		state_machine.transition_to("Move")


# Virtual function. Corresponds to the `_physics_process()` callback.
func physics_update(_delta: float) -> void:
	player.collision = player.move_and_collide(Vector2(0,0))


# Virtual function. Called by the state machine upon changing the active state. The `msg` parameter
# is a dictionary with arbitrary data the state can use to initialize itself.
func enter(_msg := {}) -> void:
	pass
#	animationSprite.play(player.get_current_dir() + "Idle" )


# Virtual function. Called by the state machine before changing the active state. Use this function
# to clean up the state.
func exit() -> void:
	pass
