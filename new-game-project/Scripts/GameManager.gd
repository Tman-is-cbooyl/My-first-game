extends Node

enum Area_Type {TAVERN, FOREST, CAVE}

var areaDict = {
	Area_Type.TAVERN: "res://Scenes/Tavern.tscn",
	Area_Type.CAVE: "res://Scenes/Cave.tscn",
	Area_Type.FOREST: "res://Scenes/world.tscn"
}

var lastArea: Area_Type

var health: float
var max_health: float
var stamina: float
var damage: float
var coin_mult: int

func _ready() -> void:
	pass

func change_area(currentArea: Area_Type):
	pass
