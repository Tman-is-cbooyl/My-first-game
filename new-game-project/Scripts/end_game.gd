extends Node3D

const SPAWN_AREA_X: Vector2 = Vector2(-11.03, 14.965)
const SPAWN_AREA_Z: Vector2 = Vector2(-14.131, 14.844) 
const SPAWN_COOLDOWN_RANDOM: Vector2 = Vector2(0.1, 0.3)
var spawn_cooldown: float = 0.2
var wave_enemies: int = 0
var enemies: int = 0
var wave: int = 1

func _process(delta: float) -> void:
	if enemies < wave_enemies:
		spawn_enemies(delta)
	if enemies == wave_enemies && $Enemies.get_child_count() == 0:
		wave += 1
		set_wave_enemies()

func set_wave_enemies() -> void:
	wave_enemies = 4 + wave
	enemies = 0

func spawn_enemies(delta: float) -> void:
	if spawn_cooldown > 0:
		spawn_cooldown -= 1 * delta
		if spawn_cooldown < 0:
			spawn_cooldown = 0
	if spawn_cooldown == 0:
		var enemy_instance: PackedScene = load("res://Objects/enemy.tscn")
		var enemy: CharacterBody3D = enemy_instance.instantiate()
		enemy.position = Vector3(randf_range(SPAWN_AREA_X.x, SPAWN_AREA_X.y), 0, randf_range(SPAWN_AREA_Z.x, SPAWN_AREA_Z.y))
		$Enemies.add_child(enemy)
		enemies += 1
