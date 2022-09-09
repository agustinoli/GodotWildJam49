extends Node

onready var parser = GodotEnv_Parser.new();
var env = {};

func _ready():
	env = parser.parse("res://.env");
	
func get(name):
	if(OS.has_environment(name)):
		return OS.get_environment(name);
		
	if(env.has(name)):
		return env[name];
	return "";
