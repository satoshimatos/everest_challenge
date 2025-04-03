extends State

class_name PlayerFloorAttack

var anim_player: AnimationPlayer

func enter():
	player.player_can_move = false
	anim_player = player.get_node("AnimationPlayer")
	if anim_player.animation_finished.is_connected(_on_animation_finished):
		anim_player.animation_finished.disconnect(_on_animation_finished)
	anim_player.animation_finished.connect(_on_animation_finished)
	if anim_player.has_animation("attack1"):
		anim_player.play("attack1")
	if player.state_label:
		update_state_label(player.state_label, self.name)

func update(_delta: float) -> void:
	player.velocity.x = 0

func _on_animation_finished(_anim_name: String):
	player.player_can_move = true
	Transitioned.emit(self, "idle")
