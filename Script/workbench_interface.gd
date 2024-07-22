extends Control

@onready var slots = $ScrollContainer/Slots
const CRAFT_SLOT = preload("res://Scene/craft_slot.tscn")
const EMPTY_ICON = preload("res://Assets/UI/Workbench/empty_icon.png")
var i = 0

@onready var craft_name = $BoxContainer/Name
@onready var description = $BoxContainer/Description
@onready var recipe = $BoxContainer/HBoxContainer/Recipe
@onready var craft_button = $BoxContainer/HBoxContainer/CraftButton


var ressources_icons = [preload("res://Assets/Environement/Forest/wood.png"),
			preload("res://Assets/Environement/Forest/rock.png"),
			preload("res://Assets/Environement/Forest/leaf.png")]
const EMPTY = preload("res://Assets/UI/Workbench/empty.png")

var workbench_zone_interaction

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
	workbench_zone_interaction = get_parent().get_node("ZoneInteractionW")
	for i in range(names.size()):
		add_craft(i, names[i], icons[i], descriptions[i], recipes[i])
	

func add_craft(p_id: int, p_craft_name: String, p_icon: CompressedTexture2D, p_description: String, p_recipe: Array):
	var slot = CRAFT_SLOT.instantiate()
	slot.get_node("CraftSlot/Icon").texture = p_icon
	slot.id = p_id
	slot.craft_name = p_craft_name
	slot.description = p_description
	slot.recipe = p_recipe
	slots.add_child(slot)
	check_achievable(slot)

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
	
	# check si l'item est réalisable et grise le bouton en fonction
	craft_button.disabled = craft_selected.is_disabled

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

func check_all_achievable():
	for i in range(slots.get_child_count()):
		check_achievable(slots.get_child(i))

func check_achievable(slot):
	var achievable = (workbench_zone_interaction.nbTree >= slot.recipe[0]) && (workbench_zone_interaction.nbRock >= slot.recipe[1]) && (workbench_zone_interaction.nbBush >= slot.recipe[2]) 
	print(slot.craft_name, " is achievable : ", achievable)
	slot.griser_slot(not achievable)
	# permet de dégriser le bouton
	if slot == slots.selected:
		craft_button.disabled = slot.is_disabled
