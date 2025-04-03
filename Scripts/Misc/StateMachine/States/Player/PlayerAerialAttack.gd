extends State

class_name PlayerAerialAttack

var anim_player: AnimationPlayer
var aerial_attack_fall_speed: float = 200


func enter():
	player.player_can_move = false
	player.affected_by_gravity = false
	
	anim_player = player.get_node("AnimationPlayer")
	if anim_player.animation_finished.is_connected(_on_animation_finished):
		anim_player.animation_finished.disconnect(_on_animation_finished)
	anim_player.animation_finished.connect(_on_animation_finished)
	if anim_player.has_animation("attack2"):
		anim_player.play("attack2")
	if player.state_label:
		update_state_label(player.state_label, self.name)

func update(delta: float) -> void:
	player.velocity.y = aerial_attack_fall_speed

func _on_animation_finished(_anim_name: String):
	player.affected_by_gravity = true
	Transitioned.emit(self, "landingattack")
