extends CharacterBody2D

@export var speed :float = 200

@onready var anim_sprite = $AnimatedSprite2D
@onready var weapon = $WeaponMark/Weapon

func _physics_process(_delta):
	manageMov()
	
	if Input.get_action_raw_strength("Hit") :
		weapon.Hit()
		#TODO (scene speciale pour les armes ?)
	
	if Input.get_action_raw_strength("Interact") :
		print("Interact !!")
		#TODO (lancer un check dans une area2d autour pour voir si y'a une interaction a faire
		#gerer les multiples possibilités
		
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
	
	if velocity.x + velocity.y && anim_sprite.animation == "Idle":
		anim_sprite.animation = "Run"
	elif !(velocity.x + velocity.y) && anim_sprite.animation == "Run":
		anim_sprite.animation = "Idle"
