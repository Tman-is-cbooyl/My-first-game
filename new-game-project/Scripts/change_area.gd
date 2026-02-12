extends Area3D

@export var currentAreaType: GameManager.Area_Type
@export var changeAreaType: GameManager.Area_Type


func _ready() -> void:
	add_to_group("changeArea")

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		GameManager.change_area(currentAreaType)
		get_tree().change_scene_to_file(GameManager.areaDict[changeAreaType])
