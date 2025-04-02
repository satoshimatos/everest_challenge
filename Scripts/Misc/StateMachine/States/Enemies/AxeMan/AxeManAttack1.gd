extends State

class_name AxeManAttack1

@export var enemy: CharacterBody2D
var anim_player: AnimationPlayer
var direction: float

func enter():
	player = get_tree().get_first_node_in_group("Player")
	anim_player = enemy.get_node("AnimationPlayer")
	if not anim_player.animation_finished.is_connected(_on_animation_finished):
		anim_player.animation_finished.connect(_on_animation_finished)
	enemy.velocity.x = 0
	if (enemy.state_label):
		update_state_label(enemy.state_label, self.name)

func exit():
	enemy.velocity.x = 0

func physics_update(delta: float):
	direction = player.global_position.x - enemy.global_position.x
	if abs(direction) <= enemy.ATTACK_DISTANCE:
		anim_player.play("attack_1")
		

func _on_animation_finished(anim_name: String) -> void:
	print("finished")
	if abs(direction) > enemy.ATTACK_DISTANCE:
		Transitioned.emit(self, "chase")
	if direction < 0:
		enemy.sprite.flip_h = true
		enemy.attack_hitbox.position.x = -enemy.attack_hitbox_original_position.x
	elif direction > 0:
		enemy.sprite.flip_h = false
		enemy.attack_hitbox.position.x = enemy.attack_hitbox_original_position.x
