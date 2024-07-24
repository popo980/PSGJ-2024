extends Control

var weapon_icons = [preload("res://Assets/UI/Workbench/empty.png"),
			preload("res://Assets/Weapons/wooden_sword.png"),
			preload("res://Assets/Weapons/stone_axe.png"),
			preload("res://Assets/Weapons/bow.png"),
			preload("res://Assets/Weapons/magic_wand.png"),
			preload("res://Assets/Weapons/knife.png")]
@onready var weapon_icon = $weaponSlot/weaponIcon
@onready var shadows = [$CraftSlot/Shadow1, $CraftSlot2/Shadow2]
var mob_names = [null, null]
var nb = 0
var shadow_icons = {
	"Sheep" : preload("res://Assets/Mob/Animals/shadow_icons/sheep_shadow_icon.png"),
	"Boar" : preload("res://Assets/Mob/Animals/shadow_icons/boar_shadow_icon.png"),
	"Fox" : null
}
var shadow_inventory
const EMPTY = preload("res://Assets/UI/Workbench/empty.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	shadow_inventory = get_parent().get_parent().get_parent().get_node("GUI/LeftPanel/shadows_inventory")
	shadow_inventory.connect("add_shadow_enchantment", Callable(self, "on_add_shadow_enchantment_signal"))


func set_weapon(weapon):
	var current_weapon = weapon.currentWeapon
	weapon_icon.texture = weapon_icons[current_weapon]

func on_add_shadow_enchantment_signal(mob_name):
	print("BHVEBVIHLBDHLVBQDUVBFDHIVBLIQBV  ", mob_name, nb)
	for i in range(2):
		if mob_names[i] == null:
			shadows[i].texture = shadow_icons[mob_name]
			mob_names[i] = mob_name
			return
	get_back_shadow(mob_name)

func get_back_shadow(mob_name):
	shadow_inventory.add_shadow(mob_name)

func _on_button_1_pressed():
	button_pressed(0)
func _on_button_2_pressed():
	button_pressed(1)

func button_pressed(i):
	if mob_names[i] != null:
		get_back_shadow(mob_names[i])
		mob_names[i] = null
		shadows[i].texture = EMPTY

func get_back_all():
	for i in range(2):
		button_pressed(i)
