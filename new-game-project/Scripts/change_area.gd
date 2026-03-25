extends Area3D

@export var scene_path: String = "res://Scenes/world.tscn"

var main

func _ready() -> void:
	add_to_group("changeArea")
	main = SceneManagerControl.get_mainframe(self)

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		main.call("change_scene", get_parent().get_path(), scene_path)
