extends KinematicBody2D

export(float) var SPEED = 200.0
export(int) var health = 3

enum STATES { IDLE, FOLLOW }
var _state = null

onready var sting = $Stinger

func _ready():
	pass


func get_sting_position():
	return $Stinger/StingPosition


func get_tween():
	return $Tween

func recieve_hit():
	health -= 1
	$StateMachine.transition_to('Hit')
