extends Area2D


var table_open : bool
var dropped : bool
@onready var enchantment_table_interface = $"../EnchantmentTableInterface"
var player

func _ready():
	player = get_parent().get_parent().get_parent().get_node("Player")

func get_item_id_type():
	return -1
	
func interact(_player):pass


func _on_body_entered(_body):
	if player.at_night:
		return
	table_open = true
	enchantment_table_interface.visible = table_open && dropped
	enchantment_table_interface.global_position = Vector2.ZERO
	player.enchantment_table_open = true
	enchantment_table_interface.set_weapon(player.weapon)
	player.can_select_shadows = true
	if player.workbench_open:
		print("workbench already open")
		enchantment_table_interface.z_index = 11
	else :
		print("workbench not open")
		enchantment_table_interface.z_index = 10


func _on_body_exited(_body):
	player.can_select_shadows = false
	table_open = false
	enchantment_table_interface.visible = table_open
	player.enchantment_table_open = false
	enchantment_table_interface.get_back_all()
