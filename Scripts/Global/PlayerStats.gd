extends Node

var stats: Dictionary

func _ready() -> void:
	stats = {
		"hp": 50,
		"attack": 5.0,
		"move_speed": 100.0,
		"defense": 1.0,
		"invulnerability_time": 2.0,
	}
