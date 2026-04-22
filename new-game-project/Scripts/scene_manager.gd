class_name scene_manager
extends Node

var player_health: int = 100
var player_coins: int = 0

var health: int = 1
var strength: int = 1
var coin_mult: int = 1

# --- LIFECYCLE ---
func _ready() -> void:
	setup()

# --- INITIALIZATION ---
func setup() -> void:
	# Loads and adds the main office scene when the game starts.
	add_scene("res://Scenes/world.tscn")

# --- SCENE MANAGEMENT ---
func add_scene(scene_path: String) -> void:
	var scene_instance = load(scene_path)
	var scene = scene_instance.instantiate()
	add_child(scene)

func remove_scene(tree_path: String) -> void:
	var scene = get_node_or_null(tree_path)
	
	if scene == null:
		print("Scene '" + tree_path + "' could not be removed. Scene could not be found.")
		return
	
	scene.queue_free()

func add_to_health(amt: int) -> void:
	health += amt
	if health < 0:
		health = 0

func get_health() -> int:
	return health

func add_to_strength(amt: int) -> void:
	strength += amt
	if strength < 0:
		strength = 0

func get_strength() -> int:
	return strength

func add_to_coin_mult(amt: int) -> void:
	coin_mult += amt
	if coin_mult < 0:
		coin_mult = 0

func get_coin_mult() -> int:
	return coin_mult

func set_player_info(hp: int, coins: int):
	player_health = hp
	player_coins = coins

func get_player_health() -> int:
	return player_health

func get_player_coins() -> int:
	return player_coins

func change_scene(old_tree_path: String, new_path: String) -> void:
	add_scene(new_path)
	remove_scene(old_tree_path)
