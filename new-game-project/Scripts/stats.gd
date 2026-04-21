extends Control

var main: Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	main = SceneManagerControl.get_mainframe(self)

func _process(delta: float) -> void:
	$PanelContainer/MarginContainer/ScrollContainer/Contents/Health/Total.text = str(main.get_health())
	$PanelContainer/MarginContainer/ScrollContainer/Contents/Strength/Total.text = str(main.get_strength())
	$PanelContainer/MarginContainer/ScrollContainer/Contents/CoinMultiplyer/Total.text = str(main.get_coin_mult())

func _on_health_minus_pressed() -> void:
	main.add_to_health(-1)
	get_parent().update_stats()

func _on_health_plus_pressed() -> void:
	main.add_to_health(1)
	get_parent().update_stats()

func _on_strength_minus_pressed() -> void:
	main.add_to_strength(-1)
	get_parent().update_stats()

func _on_strength_plus_pressed() -> void:
	main.add_to_strength(1)
	get_parent().update_stats()

func _on_coin_mult_minus_pressed() -> void:
	main.add_to_coin_mult(-1)
	get_parent().update_stats()

func _on_coin_mult_plus_pressed() -> void:
	main.add_to_coin_mult(1)
	get_parent().update_stats()
