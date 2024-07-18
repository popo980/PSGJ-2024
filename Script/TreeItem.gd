extends Area2D

@onready var item = $Item


func interact(player):
	item.hold(player)

func drop():
	item.drop()

func set_parent(parent):
	item.parent = parent

func get_item_type():
	return item.item_type
