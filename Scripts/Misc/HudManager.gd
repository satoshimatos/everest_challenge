extends CanvasLayer

@onready var hp_bar: TextureProgressBar = $HpBar
@onready var delayed_hp_bar: TextureProgressBar = $DelayedHpBar
var player: CharacterBody2D

func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	player.connect("DamageTaken", update_hp_bar)
	set_hp_bar()

func set_hp_bar():
	hp_bar.max_value = player.hp
	hp_bar.min_value = 0.0
	hp_bar.value = player.current_hp
	delayed_hp_bar.max_value = player.hp
	delayed_hp_bar.min_value = 0.0
	delayed_hp_bar.value = player.current_hp
	
func update_hp_bar(new_value: float):
	hp_bar.value = new_value
	await get_tree().create_timer(0.2).timeout  
	var tween = create_tween()
	tween.tween_property(delayed_hp_bar, "value", new_value, 0.5)
	tween.set_ease(Tween.EASE_OUT)
