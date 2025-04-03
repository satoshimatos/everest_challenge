extends Node

var enemies: Dictionary
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	enemies = {
		"type": {
			"regular": {
				"ArmoredAxeMan": {
					"hp": 30,
					"base_speed": 20,
					"attack": 3,
					"defense": 5,
					"attack_speed": 3,
					"attack_distance": 25.0,
					"give_up_distance": 150.0,
					"detection_range": 100.0,
				}
			},
			"miniboss": {},
			"boss": {}
		}
	}
