extends State

class_name EnemyChase

@export var enemy: CharacterBody2D
@export var move_speed: float = 40.0

func enter():
	player = get_tree().get_first_node_in_group("Player")
	if (enemy.state_label):
		update_state_label(enemy.state_label, self.name)

func physics_update(delta: float):
	var direction = player.global_position.x - enemy.global_position.x
	
	if direction > enemy.ATTACK_DISTANCE:
		enemy.velocity.x = move_speed
	elif direction < enemy.ATTACK_DISTANCE:
		enemy.velocity.x = -move_speed
	else:
		enemy.velocity.x = 0
		
	if enemy.velocity.x != 0:
		if enemy.anim_player.has_animation("walking"):
			enemy.anim_player.play("walking")
	
	if abs(direction) > enemy.GIVE_UP_DISTANCE:
		Transitioned.emit(self, "wander")
	if abs(direction) <= enemy.ATTACK_DISTANCE:
		Transitioned.emit(self, "attack1")
