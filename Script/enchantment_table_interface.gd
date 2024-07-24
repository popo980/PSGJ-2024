extends Control

var icons = [preload("res://Assets/UI/Workbench/empty.png"),
			preload("res://Assets/Weapons/wooden_sword.png"),
			preload("res://Assets/Weapons/stone_axe.png"),
			preload("res://Assets/Weapons/bow.png"),
			preload("res://Assets/Weapons/magic_wand.png"),
			preload("res://Assets/Weapons/knife.png")]
@onready var weapon_icon = $weaponSlot/weaponIcon

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_weapon(weapon):
	var current_weapon = weapon.currentWeapon
	weapon_icon.texture = icons[current_weapon]
