extends State

class_name EnemyChase

@export var enemy: CharacterBody2D

func enter():
	player = get_tree().get_first_node_in_group("Player")
	if (enemy.state_label):
		update_state_label(enemy.state_label, self.name)

func update(_delta):
	if enemy.current_hp <= 0:
		Transitioned.emit(self, "die")

func physics_update(delta: float):
	var direction = player.global_position.x - enemy.global_position.x
	
	if direction > enemy.attack_distance:
		enemy.velocity.x = enemy.speed * 2
	elif direction < enemy.attack_distance:
		enemy.velocity.x = -enemy.speed * 2
	else:
		enemy.velocity.x = 0
		
	if enemy.velocity.x != 0:
		if enemy.anim_player.has_animation("walking"):
			enemy.anim_player.play("walking")
	
	if abs(direction) > enemy.give_up_distance:
		Transitioned.emit(self, "wander")
	if abs(direction) <= enemy.attack_distance:
		Transitioned.emit(self, "attack1")
