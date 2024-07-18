extends Node2D

enum ListWeapon {FIST}

@onready var timer = $Timer
@onready var animation_player = $AnimationPlayer
@onready var sprite_2d = $Area2D/Sprite2D
@onready var collision_shape_2d = $Area2D/CollisionShape2D

var currentWeapon = ListWeapon.FIST
var damages = 0

func _ready():
	SwitchWeapon(ListWeapon.FIST)

func _process(_delta):
	look_at(get_global_mouse_position())

func Hit():
	if timer.is_stopped():
		animation_player.play(getWeaponName()+"Hit")
		timer.start()

func SwitchWeapon(weapon:ListWeapon):
	currentWeapon = weapon
	SetUpWeapon()
	animation_player.play(getWeaponName()+"Idle")

func SetUpWeapon():
	match currentWeapon:
		ListWeapon.FIST:
			damages = 5
			sprite_2d.set_region_rect(Rect2(3.9,4.7,7.4,7.5))
			collision_shape_2d.set_position(Vector2(0,0))
			collision_shape_2d.set_scale(Vector2(1,1))
		_:
			print("Weapon is not existant")
			
func getWeaponName():
	match currentWeapon:
		ListWeapon.FIST:
			return "Fist"
		_:
			print("Weapon is not existant")
			return ""

func _on_timer_timeout():
	animation_player.play(getWeaponName()+"Idle")

func _on_area_2d_body_entered(body):
	if body != null:
		body.get_node("Ressources").hit(damages)
