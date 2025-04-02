extends State

class_name PlayerWalk

var anim_player: AnimationPlayer

func enter():
	var anim_player = player.get_node("AnimationPlayer")
	if anim_player.has_animation("idle"):
		anim_player.play("walking")
	update_state_label(player.state_label, self.name)

func update(_delta: float):
	if player.velocity == Vector2.ZERO:
		Transitioned.emit(self, "idle")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("attack"):
		player.velocity.x = 0
		Transitioned.emit(self, "floorattack")
