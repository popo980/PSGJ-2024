extends Node2D

@onready var timer = $Timer
@onready var animation_player = $AnimationPlayer
@onready var sprite_2d = $Area2D/Sprite2D
@onready var collision_shape_2d = $Area2D/CollisionShape2D

var currentWeapon = ListWeapon.Weapons.FIST
var damages = 0
var weapon_slot
var weapon_icons = { 
	ListWeapon.Weapons.FIST: preload("res://Assets/Weapons/Hands.png"),
	ListWeapon.Weapons.WOOD_SWORD: preload("res://Assets/Weapons/wooden_sword.png"), 
	ListWeapon.Weapons.STONE_AXE: preload("res://Assets/Weapons/stone_axe.png"), 
	ListWeapon.Weapons.BOW: preload("res://Assets/Weapons/bow.png"), 
	ListWeapon.Weapons.MAGIC_WAND: preload("res://Assets/Weapons/magic_wand.png"), 
	ListWeapon.Weapons.KNIFE: preload("res://Assets/Weapons/knife.png")
}

func _ready():
	weapon_slot = get_parent().get_parent().get_parent().get_node("GUI/LeftPanel/weapon_slot")
	SwitchWeapon(ListWeapon.Weapons.FIST)

func _process(_delta):
	look_at(get_global_mouse_position())

func Hit():
	if timer.is_stopped():
		animation_player.play(getWeaponName()+"Hit")
		timer.start()

func SwitchWeapon(weapon:ListWeapon.Weapons):
	if not currentWeapon == ListWeapon.Weapons.FIST:
		DropWeapon()
	set_weapon_icon(weapon)
	currentWeapon = weapon
	SetUpWeapon()
	animation_player.play(getWeaponName()+"Idle")

func SetUpWeapon():
	sprite_2d.texture = weapon_icons[currentWeapon]
	match currentWeapon:
		ListWeapon.Weapons.FIST:
			damages = 5
			sprite_2d.set_region_rect(Rect2(3.9,4.7,7.4,7.5))
			collision_shape_2d.set_position(Vector2(0,0))
			collision_shape_2d.set_scale(Vector2(1,1))
		ListWeapon.Weapons.WOOD_SWORD:
			sprite_2d.set_region_rect(Rect2(0,0,16,16))
			damages = 10
			#TODO : completer
		_:
			print("Weapon is not existant")
			
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

func set_weapon_icon(weapon):
	weapon_slot.get_node("weapon_icon").texture = weapon_icons[weapon]
	if weapon == ListWeapon.Weapons.FIST:
		sprite_2d.set_region_rect(Rect2(3.9,4.7,7.4,7.5))
	else:
		sprite_2d.set_region_rect(Rect2(0,0,16,16))
		

func _on_timer_timeout():
	animation_player.play(getWeaponName()+"Idle")

func _on_area_2d_body_entered(body):
	if body != null:
		body.get_node("Ressources").hit(damages)
