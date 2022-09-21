extends State

export var anim_speed = 3
onready var bee = self.get_node('../../')
onready var animationSprite = self.get_node('../../AnimatedSprite')

var move_direction


func _ready():
	pass


# Virtual function. Receives events from the `_unhandled_input()` callback.
func handle_input(_event: InputEvent) -> void:
	pass


# Virtual function. Corresponds to the `_process()` callback.
func fsm_update(_delta: float) -> void:
	pass


# Virtual function. Corresponds to the `_physics_process()` callback.
func physics_update(_delta: float) -> void:
	pass


# Virtual function. Called by the state machine upon changing the active state. The `msg` parameter
# is a dictionary with arbitrary data the state can use to initialize itself.
func enter(_msg := {}) -> void:
	animationSprite.play("Hit")
	animationSprite.connect("animation_finished",self,'on_animation_ended')


# Virtual function. Called by the state machine before changing the active state. Use this function
# to clean up the state.
func exit() -> void:
	animationSprite.disconnect("animation_finished",self,'on_animation_ended')


func on_animation_ended():
	if bee.health <= 0:
		animationSprite.set_frame(1)
		var t = Timer.new()
		t.set_wait_time(1)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		bee.queue_free()
	state_machine.transition_to("Idle")

