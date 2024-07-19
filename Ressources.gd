extends Node2D

enum Ressource {TREE, ROCK, BUSH, SHEEP}
@onready var obj = $".."

@export var ressource : Ressource
@export var pv_max : float
@export var area_radius : float


var pv : float
var destroyed : bool

signal destroy_signal

func _ready():
	pv = pv_max
	connect("destroy_signal", Callable(self, "_on_destroy_signal"))

func hit(damage):
	pv -= damage
	if pv <= 0 && !destroyed:
		emit_signal("destroy_signal")
		summon_item()
		destroyed = true
	else:
		print("pv: ", pv)


func summon_item():
	var item_obj = obj.get_item()
	if item_obj != null:
		var item = item_obj.instantiate()
		call_deferred("add_child", item)
		# a besoin d'un parent pour apparaitre dans la scène une fois l'objet laché
		item.set_parent(self)
