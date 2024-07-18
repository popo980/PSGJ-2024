extends Area2D

@onready var item = $Item


func interact(player):
	get_node("Item").hold(player)

func drop():
	get_node("Item").drop()

func set_parent(parent):
	get_node("Item").parent = parent

func get_item_type():
	return item.item_type
