extends Control

const GUI_CRAFTING_BUTTON = preload("res://Scene/GUI_CraftingButton.tscn")

@onready var grid_container = $GridContainer
@onready var game_manger = get_parent().get_node(NodePath("GameManager"))
@onready var player = get_parent().get_node(NodePath("Player"))
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
	game_manger.spawn(craftName)
	player.useRessources(craftName)

