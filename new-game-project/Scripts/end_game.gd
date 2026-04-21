extends Node3D

const SPAWN_AREA_X: Vector2 = Vector2(-11.03, 14.965)
const SPAWN_AREA_Z: Vector2 = Vector2(-14.131, 14.844) 
const SPAWN_COOLDOWN_RANDOM: Vector2 = Vector2(0.1, 0.3)
var spawn_cooldown: float = 0.2
var enemies: int = 0
var wave: int = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	wave_test()
	spawn_enemies(delta)

func wave_test() -> void:
	pass # TODO: Check if Node3D "Enemies" has no children and iterate waves.

func spawn_enemies(delta: float) -> void:
	if spawn_cooldown > 0:
		spawn_cooldown -= 1 * delta
		if spawn_cooldown < 0:
			spawn_cooldown = 0
	if spawn_cooldown == 0:
		var enemy_instance: PackedScene = load("res://Objects/enemy.tscn")
		var enemy: CharacterBody3D = enemy_instance.instantiate()
		enemy.position = Vector3(randf_range(SPAWN_AREA_X.x, SPAWN_AREA_X.y), 0, randf_range(SPAWN_AREA_Z.x, SPAWN_AREA_Z.y))
		add_child(enemy)
