extends CharacterBody3D


enum States{attack, idle, chase, die}

var state = States.idle
var hp = 20
var speed = 2
var accel = 10
var gravity = 9.8
var target = null
var damage = 10
var value = 15

@export var navAgent : NavigationAgent3D
@export var animationPlayer : AnimationPlayer

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta
	if state == States.idle:
		print("idle")
		velocity = Vector3(0, velocity.y, 0)
		animationPlayer.play("Idle")
	elif state == States.chase:
		look_at(Vector3(target.global_position.x, global_position.y, target.global_position.z), Vector3.UP, true)
		animationPlayer.play("Walk")
		navAgent.target_position = target.global_position
		
		var direction = navAgent.get_next_path_position() - global_position
		direction = direction.normalized()
		velocity = velocity.lerp(direction * speed, accel * delta)
		
	elif state == States.attack:
		look_at(Vector3(target.global_position.x, global_position.y, target.global_position.z), Vector3.UP, true)
		animationPlayer.play("Punch")
		print("attack")
		velocity = Vector3.ZERO
	elif state == States.die:
		animationPlayer.play("Die")
		velocity = Vector3.ZERO
	
	move_and_slide()

func enemy():
	pass

func _process(delta):
	if hp <= 0:
		state = States.die

func give_loot():
	target.gold += value

func attack():
	target.hp -= damage

func _on_chase_area_body_entered(body: Node3D) -> void:
	if body.has_method("player") and state != States.die:
		target = body
		state = States.chase

func _on_chase_area_body_exited(body: Node3D) -> void:
	if body.has_method("player") and state != States.die:
		target = null
		state = States.idle

func _on_attack_area_body_entered(body: Node3D) -> void:
	if body.has_method("player") and state != States.die:
		state = States.attack


func _on_attack_area_body_exited(body: Node3D) -> void:
	if body.has_method("player") and state != States.die:
		state = States.chase
