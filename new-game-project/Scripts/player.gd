extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

var sensivity = 0.003
var onCooldown = false

var gold = 0
var hp = 100
var maxHP = 100
var damage = 10
var target = []

@onready var goldLable =$HUD/Gold
@onready var hpBar = $"HUD/HP Bar"
@onready var camera = $Camera3D
@onready var animationPlayer = $AnimationPlayer
@onready var cooldown = $AttackCoolDown

func _ready():
	hpBar.max_value = 100
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func player():
	pass

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * sensivity)
		camera.rotate_x(-event.relative.y * sensivity)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-60), deg_to_rad(70))

func _process(_delta):
	update_HUD()
	attack()
	if Input.is_action_just_pressed("escape"):
		get_tree().quit()

func deal_damage():
	for enemies in target:
		enemies.hp -= damage

func attack():
	if Input.is_action_just_pressed("attack") and onCooldown == false:
		animationPlayer.play("SwirdSwing")
		onCooldown = true
		cooldown.start()

func update_HUD():
	hpBar.value = hp
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
