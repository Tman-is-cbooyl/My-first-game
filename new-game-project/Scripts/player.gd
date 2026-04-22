extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const SPRINT_MULT: float = 2.0
const INPUT_COOLDOWN: float = 0.01

var input_cool: float = 0.01

var sensivity = 0.003
var onCooldown = false

var gold = 0
var hp = 100
var maxHP = 100
var damage = 10
var target = []

var start: Vector3

@onready var goldLable =$HUD/Gold
@onready var hpBar = $"HUD/HP Bar"
@onready var camera = $Camera3D
@onready var animationPlayer = $AnimationPlayer
@onready var cooldown = $AttackCoolDown

var main: Node

func _ready():
	main = SceneManagerControl.get_mainframe(self)
	start = self.position
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	update_stats()
	hp = main.call("get_player_health")
	gold = main.call("get_player_coins")
	hpBar.max_value = maxHP
	hpBar.value = hp
	if hp > maxHP:
		hp = maxHP
	

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * sensivity)
		camera.rotate_x(-event.relative.y * sensivity)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-60), deg_to_rad(70))

func player():
	pass

func _process(delta):
	handle_input(delta)
	attack()
	if Input.is_action_just_pressed("escape"):
		get_tree().quit()
	if hp <= 0:
		die()
	main.call("set_player_info", hp, gold)
	if hp < maxHP:
		hp += 5 * delta
		if hp > maxHP:
			hp = maxHP
	update_HUD()
	hpBar.max_value = maxHP
	hpBar.value = hp

func handle_input(delta: float) -> void:
	if input_cool > 0.0:
		input_cool -= 1.0 * delta
		if input_cool < 0.0:
			input_cool = 0.0
	if input_cool == 0:
		if Input.is_action_just_pressed("stats"):
			if get_node_or_null("Stats") == null:
				var stats_instance: PackedScene = load("res://Scenes/stats.tscn")
				var stats := stats_instance.instantiate()
				stats.name = "Stats"
				add_child(stats)
				Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
				input_cool = INPUT_COOLDOWN
			else:
				get_node_or_null("Stats").queue_free()
				Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			

func update_stats() -> void:
	maxHP = main.get_health() * 25
	damage = main.get_strength() * 10

func die():
	gold -= 5
	if gold < 0:
		gold = 0
	
	hp = maxHP
	position = start

func get_gold() -> int:
	return gold

func add_gold(amt: int):
	gold += amt

func deal_damage():
	for enemies in target:
		enemies.hp -= damage

func attack():
	if Input.is_action_just_pressed("attack") and onCooldown == false:
		animationPlayer.play("SwirdSwing")
		onCooldown = true
		cooldown.start()

func update_HUD():
	goldLable.text = str(gold)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "up", "down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		if Input.is_action_pressed("sprint"):
			velocity.x = direction.x * SPEED * SPRINT_MULT
			velocity.z = direction.z * SPEED * SPRINT_MULT
		else:
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()



func _on_attack_cool_down_timeout():
	onCooldown = false


func _on_attack_zone_body_entered(body: Node3D) -> void:
	if body.has_method("enemy"):
		target.append(body)


func _on_attack_zone_body_exited(body: Node3D) -> void:
	if body.has_method("enemy"):
		target.erase(body)
