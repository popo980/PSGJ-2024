extends Control

const GUI_CRAFTING_BUTTON = preload("res://Scene/GUI_CraftingButton.tscn")

@onready var grid_container = $GridContainer
var craftAvailable = []

func UpdateCrafts(listCraft: Array):
	for n in grid_container.get_children():
		grid_container.remove_child(n)
		n.queue_free()
		
	for i in listCraft:
		var craftButton = GUI_CRAFTING_BUTTON.instantiate()
		grid_container.add_child(craftButton)
		craftButton.setCraftAttribute(i)


func ButtonPressed(craftName: String):
	print("le bouton pressé est le "+ craftName)

