extends Control

var weapon_icons = [preload("res://Assets/UI/Workbench/empty.png"),
			preload("res://Assets/Weapons/wooden_sword.png"),
			preload("res://Assets/Weapons/stone_axe.png"),
			preload("res://Assets/Weapons/bow.png"),
			preload("res://Assets/Weapons/magic_wand.png"),
			preload("res://Assets/Weapons/knife.png")]
@onready var weapon_icon = $weaponSlot/weaponIcon
@onready var shadows = [$CraftSlot/Shadow1, $CraftSlot2/Shadow2]
var current_weapon
var mob_names = [null, null]
var nb = 0
var shadow_icons = {
	"Sheep" : preload("res://Assets/Mob/Animals/shadow_icons/sheep_shadow_icon.png"),
	"Boar" : preload("res://Assets/Mob/Animals/shadow_icons/boar_shadow_icon.png"),
	"Fox" : null
}
var stats = {
	"Sheep": [0, 0, 2],
	"Boar": [2, 0, 0],
	"Fox": [0, 2, 0]
}
var shadow_inventory
var player
const EMPTY = preload("res://Assets/UI/Workbench/empty.png")
@onready var description = $Description
@onready var stats_label = $Stats
@onready var enchant_stats_labels = [$att, $Speed, $PV]


var description_text = " enchanted with "
var stats_text = "Att: \nSpeed: \nP V:"
@onready var enchant_button = $EnchantButton


# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_parent().get_parent().get_parent().get_node("Player")
	shadow_inventory = get_parent().get_parent().get_parent().get_node("GUI/LeftPanel/shadows_inventory")
	shadow_inventory.connect("add_shadow_enchantment", Callable(self, "on_add_shadow_enchantment_signal"))

func set_weapon(weapon):
	if not player.weapon.enchanted:
		current_weapon = weapon.currentWeapon
		weapon_icon.texture = weapon_icons[current_weapon]
		description.text = "You need shadows to enchant a weapon"+ "\n" + stats_text
		stats_label.text = str(weapon.damages) #+ "\n" + str(weapon.speed) + "\n" + str(weapon.pv)
		#enchant_button.disabled = false
		if current_weapon == ListWeapon.Weapons.FIST:
			description.text = "You're a great alchemist but you can't enchant your fist..."
			stats_label.text = ""
			enchant_button.disabled = true
	else:
		description.text = "Already enchanted weapons can't be enchanted anymore"
		stats_label.text = ""
		enchant_button.disabled = true

func on_add_shadow_enchantment_signal(mob_name):
	if player.weapon.enchanted:
		get_back_shadow(mob_name)
		return
	for i in range(2):
		if mob_names[i] == null:
			shadows[i].texture = shadow_icons[mob_name]
			mob_names[i] = mob_name
			calcul_enchant_effects()
			description.text = "You want to enchant your "+ player.weapon.getWeaponName() + "\n" + stats_text
			enchant_button.disabled = false
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
		calcul_enchant_effects()

func get_back_all():
	for i in range(2):
		button_pressed(i)


func _on_enchant_button_pressed():
	if current_weapon != ListWeapon.Weapons.FIST && not player.weapon.enchanted && mob_names != [null, null]:
		var weapon = player.weapon
		var enchant_stats = calcul_enchant_effects()
		weapon.change_stats(enchant_stats)
		stats_label.text = str(weapon.damages)# + "\n" + str(weapon.speed) + "\n" + str(weapon.pv)
		description.text = "Already enchanted weapons can't be enchanted anymore"+ "\n" + stats_text
		enchant_button.disabled = true
		reset_slots()
	elif mob_names == [null, null]:
		description.text = "You need shadows to enchant a weapon"+ "\n" + stats_text
	elif player.weapon.enchanted:
		description.text = "Already enchanted weapons can't be enchanted anymore"+ "\n" + stats_text
	elif current_weapon == ListWeapon.Weapons.FIST:
		description.text = "You're a great alchemist but you can't enchant your fist..."+ "\n" + stats_text

func reset_slots():
	for i in range(2):
		if mob_names[i] != null:
			shadows[i].texture = EMPTY
			mob_names[i] = null
	for i in range(3):
		enchant_stats_labels[i].text = ""

func calcul_enchant_effects():
	var enchant_stats = [0, 0, 0]
	if current_weapon == ListWeapon.Weapons.FIST || player.weapon.enchanted:
		return enchant_stats
	for i in range(2):
		if mob_names[i] != null:
			for j in range(3):
				enchant_stats[j] += stats[mob_names[i]][j]
	for i in range(3):
		if (enchant_stats[i] != 0):
			enchant_stats_labels[i].text = "+ " + str(enchant_stats[i])
		else:
			enchant_stats_labels[i].text = ""
	return enchant_stats
