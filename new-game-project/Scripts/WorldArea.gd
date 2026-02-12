class_name WorldArea extends Node3D

var player: CharacterBody3D

func _ready() -> void:
	player = get_node_or_null("player")
	if player == null:
		push_warning("Player not found in scene!")
	player.position = $Marker3D.position
