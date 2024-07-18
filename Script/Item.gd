extends Node2D

enum ITEM_TYPE {TREE,ROCK,BUSH}


var is_held : bool
var player_holding : CharacterBody2D
@export var offset : Vector2
@export var obj : Area2D
@export var item_type : ITEM_TYPE
var parent

func _ready():
	is_held = false

func use():
	queue_free()

func hold(player):
	is_held = true
	player_holding = player
	if obj.get_parent():
		obj.get_parent().remove_child(obj)
	player_holding.add_child(obj)
	obj.position = Vector2.ZERO
	player.is_holding = true
	player.item_held = obj

func drop():
	print("DROP")
	is_held = false
	var item = player_holding.item_held
	player_holding.is_holding = false
	player_holding.item_held = null
	item.get_parent().remove_child(item)
	parent.add_child(item)
	item.global_position = player_holding.global_position
	

