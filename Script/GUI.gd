extends Control

signal night_signal
const GUI_CRAFTING_BUTTON = preload("res://Scene/GUI_CraftingButton.tscn")

@export var timeDay :float= 30

@onready var day_night_cycle = $DayNightCycle
@onready var grid_container = $GridContainer
@onready var game_manager = get_parent().get_node(NodePath("GameManager"))
@onready var player = get_parent().get_node(NodePath("Player"))
var craftAvailable = []

func _ready():
	connect("night_signal", Callable(self, "on_night_signal"))
	day_night_cycle.timeEnd = timeDay
	
	
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
	game_manager.spawn(craftName)
	player.useRessources(craftName)

func Night():
	emit_signal("night_signal")
