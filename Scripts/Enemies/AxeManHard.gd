extends ArmoredAxeMan

class_name ArmoredAxeManHard

@onready var obstacle_raycast: RayCast2D = $ObstacleRayCast

func _ready() -> void:
	player.DamageDealt.connect(_take_damage)
	set_hp_bar()
	attack_hitbox_disabler(true)

func flip_enemy():
	if velocity.x < 0:
		sprite.flip_h = true
		attack_hitbox.position.x = -attack_hitbox_original_position.x
		obstacle_raycast.rotation_degrees = 180
	elif velocity.x > 0:
		sprite.flip_h = false
		attack_hitbox.position.x = attack_hitbox_original_position.x
		obstacle_raycast.rotation_degrees = 0

func attack_hitbox_disabler(is_active: bool):
	attack_hitbox.get_node("CollisionShape2D").disabled = is_active

func _on_attack_hitbox_body_entered(body: Node2D) -> void:
	if body == player:
		if not player.is_invulnerable:
			player._take_damage(attack, self)
