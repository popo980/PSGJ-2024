extends Control

@onready var slots = $ScrollContainer/Slots
const CRAFT_SLOT = preload("res://Scene/craft_slot.tscn")
const EMPTY_ICON = preload("res://Assets/UI/Workbench/empty_icon.png")
var i = 0

@onready var craft_name = $BoxContainer/Name
@onready var description = $BoxContainer/Description
@onready var recipe = $BoxContainer/HBoxContainer/Recipe

var ressources_icons = [preload("res://Assets/Environement/Forest/wood.png"),
			preload("res://Assets/Environement/Forest/rock.png"),
			preload("res://Assets/Environement/Forest/leaf.png")]
const EMPTY = preload("res://Assets/UI/Workbench/empty.png")

# ------------------- CRAFTS INFORMATIONS -----------------------------------------------------------------------------------------------
var names = ["Wood Sword", "Stone Axe", "Bow", "Magic Wand", "Knife"]
var descriptions = ["A basic wooden sword, not very strong but better than fighting bare-handed",
					"Who said an axe was only for chopping wood? With this stone axe, you can defend yourself with ease.",
					"A bow, perfect for hitting targets from a distance! avoid hand-to-hand combat with this weapon.",
					"magic wand description",
					"knife description"]
var icons = [preload("res://Assets/Weapons/wooden_sword.png"),
			preload("res://Assets/Weapons/stone_axe.png"),
			preload("res://Assets/Weapons/bow.png"),
			preload("res://Assets/Weapons/magic_wand.png"),
			preload("res://Assets/Weapons/knife.png")]
var recipes = [[1,0,0], [1, 2, 0], [1,0,2], [3,1,0], [0,2,1]]
# ----------------------------------------------------------------------------------------------------------------------------------------


func _ready():
	for i in range(names.size()):
		add_craft(i, names[i], icons[i], descriptions[i], recipes[i])
	

func add_craft(id: int, craft_name: String, icon: CompressedTexture2D, description: String, recipe: Array):
	var slot = CRAFT_SLOT.instantiate()
	slot.get_node("CraftSlot/Icon").texture = icon
	slot.id = id
	slot.craft_name = craft_name
	slot.description = description
	slot.recipe = recipe
	slots.add_child(slot)

func _on_slots_craft_selected(id):
	var craft_selected = slots.get_child(id)
	craft_name.text = craft_selected.craft_name
	description.text = craft_selected.description
	
	# remplis les slots selon le craft sélectionné
	var number = 0
	for i in range(craft_selected.recipe.size()):
		for j in range(craft_selected.recipe[i]):
			set_slot_recipe(number, ressources_icons[i])
			number += 1
	
	# remplis les slots vide par une texture vide
	if number < 4 :
		for i in range(number, 4):
			set_slot_recipe(i, EMPTY)

func set_slot_recipe(indice, icon):
	match indice:
		0:
			get_node("BoxContainer/HBoxContainer/Recipe/Row1/CraftSlot/Sprite2D").texture = icon
		1:
			get_node("BoxContainer/HBoxContainer/Recipe/Row1/CraftSlot2/Sprite2D").texture = icon
		2:
			get_node("BoxContainer/HBoxContainer/Recipe/Row2/CraftSlot/Sprite2D").texture = icon
		3:
			get_node("BoxContainer/HBoxContainer/Recipe/Row2/CraftSlot2/Sprite2D").texture = icon
