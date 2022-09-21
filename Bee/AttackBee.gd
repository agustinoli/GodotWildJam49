extends State

export var attack_anim_speed = 2
onready var bee = self.get_node('../../')
onready var animationSprite : AnimatedSprite = self.get_node('../../AnimatedSprite')
onready var player: KinematicBody2D
onready var stingScene : PackedScene = load ("res://Sting/Sting.tscn")

var move_direction
onready var prev_state: State

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
	animationSprite.play("Attack")
	animationSprite.set_speed_scale(attack_anim_speed)
	bee.get_tween().interpolate_property(bee, "rotation",
		bee.get_rotation(),bee.get_angle_to(player.get_position()) - PI/2, 0.05,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	bee.get_tween().start()


# Virtual function. Called by the state machine before changing the active state. Use this function
# to clean up the state.
func exit() -> void:
	pass

func _on_AttackArea_body_entered(body):
	if body.get_name() == 'Player':
		player = body
		state_machine.transition_to("Attack")


func _on_AnimatedSprite_frame_changed():
	if animationSprite.get_animation() == "Attack" && animationSprite.get_frame() == 5:
			var sting = stingScene.instance()
			sting.set_position(bee.get_sting_position().get_global_position())
			sting.set_rotation(bee.get_rotation()) 
			self.get_tree().get_current_scene().add_child( sting )
			look_at(player.get_position())


func _on_AttackArea_body_exited(body):
	if body.get_name() == 'Player':
		state_machine.transition_to("Idle")


func look_at(target: Vector2):
	pass
