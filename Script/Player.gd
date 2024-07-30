extends CharacterBody2D

const DEATH = preload("res://Assets/SFX/death.mp3")
const HURT = preload("res://Assets/SFX/hurt.mp3")

@export var max_hp:int = 80
@export var max_speed :float = 200

@onready var audio_stream_player = $AudioStreamPlayer
@onready var anim_sprite = $AnimatedSprite2D
@onready var weapon = $WeaponMark/Weapon
@onready var zone_interaction = $ZoneInteraction
@onready var shadow = $Shadow
@onready var particles = $Particles
@onready var collision_shape_2d = $CollisionShape2D
@onready var weapon_mark = $WeaponMark
@onready var death_timer = $DeathTimer

var hp:int= max_hp
var speed := max_speed

var is_holding : bool
var item_held : Area2D
var craft_held

var workbench_open : bool
var enchantment_table_open : bool

var gui
var shadow_inventory
var can_select_shadows = false


func _ready():
	shadow_inventory = get_parent().get_node("GUI/LeftPanel/shadows_inventory")
	gui = get_parent().get_node("GUI")
	gui.night_signal.connect(_on_gui_night_signal)

func _physics_process(_delta):
	manageMov()
	
	if Input.get_action_raw_strength("Hit") :
		weapon.Hit()
	
	# un objet vient d'etre craft et est dans la main du joueur, il doit donc le poser
	if Input.is_action_just_pressed("Interact") && not craft_held == null:
		craft_held.drop()
		craft_held = null
	
	# ramasse un objet à terre si le joueur ne tient rien dans les mains et qu'il y a un objet à proximité
	if Input.is_action_just_pressed("Interact") && not is_holding && zone_interaction.inZone.size() > 0:
		var nearest_obj  = find_nearest(zone_interaction.inZone)
		nearest_obj.interact(self)
	# pose un objet à terre si le joueur tient un objet dans les mains
	elif Input.is_action_just_pressed("Interact") && is_holding && item_held != null:
		item_held.drop()
		
	move_and_slide()

func manageMov():
	if hp<0:
		return
	
	if get_global_mouse_position().x > global_position.x:
		anim_sprite.flip_h = true
		weapon_mark.position.x= -3
		shadow.changeSide(true)
	else: 
		anim_sprite.flip_h = false
		weapon_mark.position.x= 2
		shadow.changeSide(false)
		
	var directionVer = Input.get_axis("WalkUp", "WalkDown")
	var directionHor = Input.get_axis("WalkLeft", "WalkRight")
	if directionVer && directionHor:
		velocity.x = directionHor* (speed/2)
		velocity.y = directionVer* (speed/2)
	elif directionHor:
		velocity.x = directionHor* speed
		velocity.y = move_toward(velocity.y, 0, speed)
	elif directionVer:
		velocity.y = directionVer* speed
		velocity.x = move_toward(velocity.x, 0, speed)
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.y = move_toward(velocity.y, 0, speed)
	
	if velocity.x + velocity.y && anim_sprite.animation == "idle":
		change_animation("run")
	elif !(velocity.x + velocity.y) && anim_sprite.animation == "run":
		change_animation("idle")

func distance(obj1, obj2):
	return (obj1.global_position.x-obj2.global_position.x)**2 + (obj1.global_position.y-obj2.global_position.y)**2

func find_nearest(tab):
	var dist_min = distance(self, tab[0])
	var nearest_obj = tab[0]
	var dist
	for i in range(1, tab.size()):
		dist = distance(self, tab[i])
		if dist < dist_min:
			dist_min = dist
			nearest_obj = tab[i]
	return nearest_obj

func useRessources(craftName:String):
	zone_interaction.useRessources(craftName)

func change_animation(new_animation):
	anim_sprite.animation = new_animation
	shadow.change_animation(new_animation)

func add_shadow_inventory(mob_name):
	shadow_inventory.add_shadow(mob_name)

func get_hit(damages:int):
	hp-=damages
	gui.UpdateHealth(max_hp,hp)
	if hp<=0:
		anim_sprite.visible=false
		zone_interaction.visible = false
		weapon_mark.visible = false
		collision_shape_2d.disabled = true
		particles.emitting = true
		audio_stream_player.stream = DEATH
		death_timer.start()
	else:
		audio_stream_player.stream = HURT
	audio_stream_player.play()

func SetMaxHealth(newMax:int):
	max_hp = newMax
	hp = max_hp
	gui.UpdateHealth(max_hp,hp)

func _on_gui_night_signal():
	zone_interaction.disappear()

func zone_active():
	zone_interaction.call_deferred("reappear")


func _on_death_timer_timeout():
	gui.OnPlayerDeath()
