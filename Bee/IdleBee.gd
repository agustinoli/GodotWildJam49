extends State

onready var bee = self.get_node('../../')
onready var animationSprite = self.get_node('../../AnimatedSprite')

# Virtual function. Receives events from the `_unhandled_input()` callback.
func handle_input(_event: InputEvent) -> void:
	pass


# Virtual function. Corresponds to the `_process()` callback.
func fsm_update(_delta: float) -> void:
	pass

# Virtual function. Corresponds to the `_physics_process()` callback.
func physics_update(_delta: float) -> void:
	pass
#	bee.move_to(bee.get_position() + Vector2(10,0))


# Virtual function. Called by the state machine upon changing the active state. The `msg` parameter
# is a dictionary with arbitrary data the state can use to initialize itself.
func enter(_msg := {}) -> void:
	animationSprite.play("Idle")
	animationSprite.set_speed_scale(0.8)
	bee.get_tween().interpolate_property(bee, "rotation",
		bee.get_rotation(),0, 1,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	bee.get_tween().start()


# Virtual function. Called by the state machine before changing the active state. Use this function
# to clean up the state.
func exit() -> void:
	print_debug('Sali de idle')


func _on_AttackArea_body_exited(body):
	if body.get_name() == 'Player':
		state_machine.transition_to("Idle")


