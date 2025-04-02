extends State

class_name PlayerIdle

var anim_player: AnimationPlayer

func enter():
	anim_player = player.get_node("AnimationPlayer")
	if anim_player.has_animation("idle"):
		anim_player.play("idle")
	if player.state_label:
		update_state_label(player.state_label, self.name)

func update(delta: float) -> void:
	if player.velocity != Vector2.ZERO:
		Transitioned.emit(self, "walk")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("attack"):
		Transitioned.emit(self, "floorattack")
