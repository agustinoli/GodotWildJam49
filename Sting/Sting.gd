extends RigidBody2D

export onready var speed = 200
export onready var broken_time = 0.7
onready var t = Timer.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite.play("default")
	GlobalTimer.add_timeout(self,"_on_timeout",10)
	t.set_one_shot(true)
	t.set_wait_time(broken_time)
	self.add_child(t)
	set_gravity_scale(0)
	set_contact_monitor(true)
	set_max_contacts_reported(1)
	apply_impulse(Vector2(),Vector2(0,speed).rotated(rotation))


func _process(_delta ):
	pass


func _on_Sting_body_shape_entered(_body_rid, body, _body_shape_index, _local_shape_index):
	if body is KinematicBody2D: 
		body.recieve_hit()
	$Sprite.play("Broken")
	t.start()
	yield(t, "timeout")
	queue_free()


func _on_timeout():
	queue_free()
