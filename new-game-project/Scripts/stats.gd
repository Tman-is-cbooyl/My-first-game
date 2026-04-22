extends Control

var main: Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	main = SceneManagerControl.get_mainframe(self)

func _process(delta: float) -> void:
	$PanelContainer/MarginContainer/ScrollContainer/Contents/Health/Total.text = str(main.get_health())
	$PanelContainer/MarginContainer/ScrollContainer/Contents/Strength/Total.text = str(main.get_strength())
	$PanelContainer/MarginContainer/ScrollContainer/Contents/CoinMultiplyer/Total.text = str(main.get_coin_mult())

func upgrade_available() -> bool:
	return get_parent().call("get_gold") >= 50

func give_gold() -> void:
	get_parent().call("add_gold", 25)

func subtract_gold() -> void:
	get_parent().call("add_gold", -50)

func _on_health_minus_pressed() -> void:
	main.add_to_health(-1)
	give_gold()
	get_parent().update_stats()

func _on_health_plus_pressed() -> void:
	if upgrade_available():
		main.add_to_health(1)
		get_parent().update_stats()
		subtract_gold()

func _on_strength_minus_pressed() -> void:
	main.add_to_strength(-1)
	give_gold()
	get_parent().update_stats()

func _on_strength_plus_pressed() -> void:
	if upgrade_available():
		main.add_to_strength(1)
		get_parent().update_stats()
		subtract_gold()

func _on_coin_mult_minus_pressed() -> void:
	main.add_to_coin_mult(-1)
	give_gold()
	get_parent().update_stats()

func _on_coin_mult_plus_pressed() -> void:
	if upgrade_available():
		main.add_to_coin_mult(1)
		get_parent().update_stats()
		subtract_gold()
