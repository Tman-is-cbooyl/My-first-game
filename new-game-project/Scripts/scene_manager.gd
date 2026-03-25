class_name scene_manager
extends Node

# --- LIFECYCLE ---
func _ready() -> void:
	setup()

# --- INITIALIZATION ---
func setup() -> void:
	# Loads and adds the main office scene when the game starts.
	add_scene("res://scenes/main_menu.tscn")

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

func change_scene(old_tree_path: String, new_path: String) -> void:
	add_scene("res://scenes/loading_screen.tscn")
	add_scene(new_path)
	remove_scene(old_tree_path)
