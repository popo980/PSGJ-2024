extends Control

signal night_signal
const GUI_CRAFTING_BUTTON = preload("res://Scene/GUI_CraftingButton.tscn")

@export var timeDay :float= 30

@onready var day_night_cycle = $DayNightCycle
@onready var grid_container = $GridContainer
@onready var texture_progress_bar = $TextureProgressBar
@onready var label = $TextureProgressBar/Label
@onready var death_screen = $DeathScreen

@onready var game_manager = get_parent().get_node(NodePath("GameManager"))
@onready var player = get_parent().get_node(NodePath("Player"))

var craftAvailable = []
var titleScreen = "res://Scene/levels/title_screen.tscn"

func _ready():
	connect("night_signal", Callable(self, "on_night_signal"))
	day_night_cycle.timeEnd = timeDay
	death_screen.visible = false
	
	
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

func UpdateHealth(max_hp:int,hp:int):
	texture_progress_bar.max_value = max_hp
	texture_progress_bar.value = hp
	label.text = str(hp)

func OnPlayerDeath():
	death_screen.visible = true

func _on_play_button_pressed():
	game_manager.restart()


func _on_quit_button_pressed():
	get_tree().root.add_child(load(titleScreen).instantiate())
	queue_free()
