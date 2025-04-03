extends State

class_name PlayerTakeDamage

var anim_player: AnimationPlayer

const KNOCKBACK_FORCE = 10.0
const KNOCKBACK_DURATION = 0.3

func enter():
	player.give_invulnerability()
	var attacker_position = player.last_attacker.global_position
	var knockback_direction: int = 1
	player.velocity = Vector2.ZERO  # Stop movement
	anim_player = player.get_node("AnimationPlayer")
	
	if anim_player.has_animation("damage"):
		anim_player.play("damage")
	knockback_direction = 1
	if attacker_position.x > player.global_position.x:
		knockback_direction = -1
	var tween = create_tween()
	var knockback_vector = Vector2(KNOCKBACK_FORCE * knockback_direction, -KNOCKBACK_FORCE / 2)

	tween.tween_property(player, "position", player.position + knockback_vector, KNOCKBACK_DURATION)
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_OUT)

	await tween.finished
	Transitioned.emit(self, "idle")
	
func exit():
	pass
