extends CharacterBody2D

@export var speed :float = 200

@onready var anim_sprite = $AnimatedSprite2D
@onready var weapon = $WeaponMark/Weapon
@onready var zone_interaction = $ZoneInteraction
@onready var shadow = $Shadow


var is_holding : bool
var item_held : Area2D

func _physics_process(_delta):
	manageMov()
	
	if Input.get_action_raw_strength("Hit") :
		weapon.Hit()
		#TODO (scene speciale pour les armes ?)
	
	# ramasse un objet à terre si le joueur ne tient rien dans les mains et qu'il y a un objet à proximité
	if Input.is_action_just_pressed("Interact") && not is_holding && zone_interaction.inZone.size() > 0:
		print("Interact !!")
		var nearest_obj  = find_nearest(zone_interaction.inZone)
		print("nearest :",nearest_obj.name)
		nearest_obj.interact(self)
		
	# pose un objet à terre si le joueur tient un objet dans les mains
	elif Input.is_action_just_pressed("Interact") && is_holding && item_held != null:
		print("drop1")
		item_held.drop()
		
	move_and_slide()

func manageMov():
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
