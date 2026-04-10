extends Control

var main: Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	main = SceneManagerControl.get_mainframe(self)

func _process(delta: float) -> void:
	$PanelContainer/MarginContainer/ScrollContainer/Health/HBoxContainer/Total.text = str(main.get_health())

func _on_health_minus_pressed() -> void:
	main.add_to_health(-1)
