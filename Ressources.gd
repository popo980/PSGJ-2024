extends Node2D

enum Ressource {TREE, ROCK, BUSH}

@export var ressource : Ressource
@export var pv_max : float
@export var area_radius : float
@export var sprite : Node2D
@export var obj : StaticBody2D
@export var particle : CPUParticles2D
@export var item_path : String

var pv : float
var destroyed : bool

signal destroy_signal

func _ready():
	pv = pv_max
	connect("destroy_signal", Callable(obj, "_on_destroy_signal"))

func hit(damage):
	pv -= damage
	if pv <= 0 && !destroyed:
		# envoyer un signal
		emit_signal("destroy_signal")
		summon_item()
		destroyed = true
		sprite.queue_free()
		particle.emitting = true
	print("pv: ", pv)


func summon_item():
	print("item summoned")
	var item = load(item_path).instantiate()
	#add_child(item)
	call_deferred("add_child", item)
