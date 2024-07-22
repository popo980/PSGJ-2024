extends Area2D

enum ITEM_TYPE {TREE=0,ROCK=1,BUSH=2}


var is_held : bool
var player_holding : CharacterBody2D
@export var offset : Vector2
@export var item_type : ITEM_TYPE
var parent

func _ready():
	is_held = false

func use():
	queue_free()

func interact(player):
	hold(player)


func hold(player):
	is_held = true
	player_holding = player
	if get_parent():
		get_parent().remove_child(self)
	player_holding.add_child(self)
	position = Vector2.ZERO
	player.is_holding = true
	player.item_held = self

func drop():
	print("DROP")
	is_held = false
	var item = player_holding.item_held
	player_holding.is_holding = false
	player_holding.item_held = null
	item.get_parent().remove_child(item)
	parent.add_child(item)
	item.global_position = player_holding.global_position
	
func get_item_id_type():
	print("OK ITEM TYPE : ", item_type)
	return int(item_type)

func set_parent(p):
	parent = p
