extends Node2D

var main
var player
@onready var zone_interaction = $ZoneInteractionE
@onready var collision_shape = $CollisionShape2D

# shadows effect : 
#	sheep increase critical hit
#	boar increase damage
#	bee increase speed

func _ready():
	player = get_parent()
	main = get_parent().get_parent()

func drop():
	get_parent().remove_child(self)
	main.add_child(self)
	global_position = player.global_position
	scale = Vector2(2,2)
	zone_interaction.visible = true
	collision_shape.disabled = false
	zone_interaction.dropped = true
