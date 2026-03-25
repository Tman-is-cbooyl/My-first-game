extends Area3D

@export var currentAreaType: GameManager.Area_Type
@export var changeAreaType: GameManager.Area_Type


func _ready() -> void:
	add_to_group("changeArea")

func change_scene(scn: String) -> void:
	get_tree().change_scene_to_file(scn)

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		GameManager.change_area(currentAreaType)
		call_deferred("change_scene", GameManager.areaDict[changeAreaType])
