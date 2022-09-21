extends KinematicBody2D
class_name Player

export var NORMAL_SPEED = 3

const MIN_ZOOM = 0.5
const MAX_ZOOM = 30.0

var speed = NORMAL_SPEED

var directions = ["Right", "RightDown", "Down", "LeftDown", "Left", "LeftUp", "Up", "RightUp"]
var current_direction: String = "Down" setget set_current_dir, get_current_dir
var facing = Vector2() setget set_facing, get_facing

var collision

onready var log_active = false

func get_camera():
	return $Camera2D


func set_current_dir(new_dir: String):
	current_direction = new_dir


func get_current_dir() -> String:
	return current_direction


func get_dir(index: int) -> String:
	return directions[index]


func set_facing(new_facing: Vector2):
	facing = new_facing


func get_facing() -> Vector2:
	return facing


func get_animationSprite () -> Node:
	return $AnimatedSprite


func _ready():
	find_node("Log").init()


func _process(_delta):
	if Input.is_action_just_released("zoom_in"):
		var p_zoom = $Camera2D.get_zoom().x+0.1
		p_zoom = clamp(p_zoom, MIN_ZOOM, MAX_ZOOM)
		$Camera2D.set_zoom(Vector2(p_zoom,p_zoom))
	elif Input.is_action_just_released("zoom_out"):
		var p_zoom = $Camera2D.get_zoom().x-0.1
		p_zoom = clamp(p_zoom, MIN_ZOOM, MAX_ZOOM)
		$Camera2D.set_zoom(Vector2(p_zoom,p_zoom))


func blackout():
	var tween = create_tween()
	tween.tween_property($Camera2D/CanvasModulate, "color", Color(0,1,1,1),2)
	GlobalTimer.add_timeout(self,"_on_blackout_timeout",3)


func _on_blackout_timeout():
	var tween = create_tween()
	tween.tween_property($Camera2D/CanvasModulate, "color", Color(1,1,1,1),2)


func set_recursive_process_input(state : bool):
	self.set_physics_process(state)
	$StateMachine.set_physics_process(state)
	$StateMachine/Build.set_physics_process(state)
	$StateMachine/Idle.set_physics_process(state)
	$StateMachine/Move.set_physics_process(state)


func parse_input():
	pass


func get_audio_stream():
	return $AudioStreamPlayer


func next_log():
	$Log.next()


func recieve_hit():
	print("auch! maybe add some inestability")
