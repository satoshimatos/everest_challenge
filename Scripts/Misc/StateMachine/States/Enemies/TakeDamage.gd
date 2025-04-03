extends State

class_name TakeDamage

@export var enemy: CharacterBody2D
var anim_player: AnimationPlayer

func update(_delta):
	if enemy.current_hp <= 0:
		Transitioned.emit(self, "die")

func enter():
	enemy.can_move = false
	flash_white()
	anim_player = enemy.get_node("AnimationPlayer")
	anim_player.stop()
	if anim_player.animation_finished.is_connected(_on_animation_finished):
		anim_player.animation_finished.disconnect(_on_animation_finished)
	anim_player.animation_finished.connect(_on_animation_finished)
	if anim_player.has_animation("damage"):
		anim_player.play("damage")
	if (enemy.state_label):
		update_state_label(enemy.state_label, self.name)

func exit():
	enemy.can_move = true

func physics_update(delta: float):
	var direction = player.global_position.x - enemy.global_position.x

func _on_animation_finished(_anim_name: String) -> void:
	if enemy.current_hp > 0:
		Transitioned.emit(self, "wander")

func flash_white():
	var tween = create_tween()
	enemy.sprite.modulate = Color(5, 5, 5, 1)
	tween.tween_property(enemy.sprite, "modulate", Color(1, 1, 1, 1), 0.1)

	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_OUT)
	#tween.tween_callback(enemy.queue_free)
