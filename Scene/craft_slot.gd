extends Control

@onready var select_icon = $CraftSlot/Select
var mouse = false
var id : int
var craft_name : String
var description : String
var recipe : Array
var slots

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
	select_icon.visible = selected
	if selected:
		slots.select(id)
