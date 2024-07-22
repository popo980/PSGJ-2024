extends Control

@onready var select_icon = $CraftSlot/Select
@onready var icone_grisee = $CraftSlot/IconeGrisee

var mouse = false
var id : int
var craft_name : String
var description : String
var recipe : Array
var slots
var is_disabled = true

func _ready():
	select_icon.visible = false
	slots = get_parent()
	# sélectionne par défaut le premier élément
	if id ==0:
		select(true)

func _on_mouse_entered():
	mouse = true

func _on_mouse_exited():
	mouse = false

func _process(_delta):
	if Input.is_action_just_pressed("Hit"):
		select(mouse)
	
func select(selected):
	if selected:
		if slots.selected != null:
			slots.selected.select_icon.visible = false
		select_icon.visible = true
		slots.selected = self
		slots.select(id)

func griser_slot(griser: bool):
	is_disabled = griser
	icone_grisee.visible = griser
