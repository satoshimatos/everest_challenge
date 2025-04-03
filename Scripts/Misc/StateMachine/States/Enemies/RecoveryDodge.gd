extends State

class_name RecoveryDodge

@export var enemy: CharacterBody2D
@export var dodge_speed: float = 150  # Speed for dodging backward
@export var jump_force: float = -130  # Slight hop upward
@export var dodge_duration: float = 0.3  # How long dodge movement lasts

var dodging: bool = false

func enter():
	enemy.can_move = false
	if !enemy or !player:
		return  # Safety check
	var anim_player = enemy.get_node("AnimationPlayer")

	enemy.is_invulnerable = true
	dodging = true

	var direction = sign(enemy.global_position.x - player.global_position.x)

	enemy.velocity.x = dodge_speed * direction
	enemy.velocity.y = jump_force

	if anim_player.has_animation("jump"):
		anim_player.play("jump")
	await anim_player.animation_finished

	enemy.velocity.x = 0  

	while not enemy.is_on_floor():
		await get_tree().process_frame

	dodging = false

	enemy.is_invulnerable = false
	enemy.can_move = true
	Transitioned.emit(self, "wander")

func physics_update(delta: float):
	if dodging:
		if not enemy.is_on_floor():
			enemy.velocity.y += enemy.gravity * delta
		enemy.move_and_slide()
	else:
		enemy.velocity.x = 0
