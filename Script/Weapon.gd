extends Node2D

@onready var cooldown = $Timer
@onready var animation_player = $AnimationPlayer
@onready var sprite_2d = $Area2D/Sprite2D
@onready var collision_shape_2d = $Area2D/CollisionShape2D

var currentWeapon = ListWeapon.Weapons.FIST
var damages = 0
var weapon_slot
var weapon_icons = { 
	ListWeapon.Weapons.FIST: preload("res://Assets/Weapons/Fist.png"),
	ListWeapon.Weapons.WOOD_SWORD: preload("res://Assets/Weapons/wooden_sword.png"), 
	ListWeapon.Weapons.STONE_AXE: preload("res://Assets/Weapons/stone_axe.png"), 
	ListWeapon.Weapons.BOW: preload("res://Assets/Weapons/bow.png"), 
	ListWeapon.Weapons.MAGIC_WAND: preload("res://Assets/Weapons/magic_wand.png"), 
	ListWeapon.Weapons.KNIFE: preload("res://Assets/Weapons/knife.png"),
	ListWeapon.Weapons.NOT_A_WEAPON: preload("res://Assets/UI/Workbench/empty.png")
}

var speed
var pv

# [damage, speed, pv]
var weapon_stats = {
	ListWeapon.Weapons.FIST: [5, 0.4, 10],
	ListWeapon.Weapons.WOOD_SWORD: [10, 0.5, 10],
	ListWeapon.Weapons.STONE_AXE: [15, 0.6, 10],
	ListWeapon.Weapons.BOW: [10, 0.5, 10],
	ListWeapon.Weapons.MAGIC_WAND: [8, 0.2, 15],
	ListWeapon.Weapons.KNIFE: [10, 0.2, 10]
}

var enchanted = false

func _ready():
	weapon_slot = get_parent().get_parent().get_parent().get_node("GUI/LeftPanel/weapon_slot")
	SwitchWeapon(ListWeapon.Weapons.FIST)

func _process(_delta):
	look_at(get_global_mouse_position())

func Hit():
	if cooldown.is_stopped():
		#animation_player.play(getWeaponName()+"Hit")
		animation_player.play("FistHit")
		cooldown.start()

func SwitchWeapon(weapon:ListWeapon.Weapons):
	if not currentWeapon == ListWeapon.Weapons.FIST:
		DropWeapon()
	currentWeapon = weapon
	set_weapon_icon()
	SetUpWeapon()
	#animation_player.play(getWeaponName()+"Idle")
	animation_player.play("FistIdle")

func SetUpWeapon():
	sprite_2d.texture = weapon_icons[currentWeapon]
	damages = weapon_stats[currentWeapon][0]
	cooldown.wait_time = weapon_stats[currentWeapon][1]
	speed = 10 - weapon_stats[currentWeapon][1] * 10
	pv = weapon_stats[currentWeapon][2]
	
	#match currentWeapon:
		#ListWeapon.Weapons.FIST:
			#damages = 5
			#cooldown.wait_time = 0.3
		#ListWeapon.Weapons.WOOD_SWORD:
			#damages = 10
			#cooldown.wait_time = 0.5
		#_:
			#print("Weapon is not existant")
			
func getWeaponName():
	match currentWeapon:
		ListWeapon.Weapons.FIST:
			return "Fist"
		ListWeapon.Weapons.WOOD_SWORD:
			return "Wood_sword"
		_:
			print("Weapon is not existant")
			return ""

func DropWeapon():
	# TODO: drop weapon
	pass

func set_weapon_icon():
	weapon_slot.get_node("weapon_icon").texture = weapon_icons[currentWeapon]

func _on_timer_timeout():
	#animation_player.play(getWeaponName()+"Idle")
	animation_player.play("FistIdle")
	
func _on_area_2d_body_entered(body):
	if body != null:
		body.get_node("Ressources").hit(damages)

# [att, speed, pv]
func change_stats(enchant_stats):
	damages += enchant_stats[0]
	speed += enchant_stats[1]
	cooldown.wait_time = (10 - speed)/10
	pv += enchant_stats[2]
	enchanted = true
