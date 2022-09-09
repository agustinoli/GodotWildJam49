extends Node

export var key: String

func _ready():
	$Key.set_text(key)
	print("key is: ",key)
	$Value.set_text(Env.get(key))
	print("value is: ",Env.get(key))
