extends CharacterBody2D

class_name ArmoredAxeMan

@onready var sprite: Sprite2D = $Sprite
@onready var state_label: Label = $StateLabel
@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var attack_hitbox: Area2D = $AttackHitbox
@onready var attack_hitbox_original_position = attack_hitbox.position

@export var speed: int = 50

var direction: Vector2
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

const ATTACK_DISTANCE = 25.0
const GIVE_UP_DISTANCE = 150.0

func _ready() -> void:
	attack_hitbox_disabler(true)

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
		
	state_label.global_position = self.global_position
	flip_enemy()
	move_and_slide()

func flip_enemy():
	if velocity.x < 0:
		sprite.flip_h = true
		attack_hitbox.position.x = -attack_hitbox_original_position.x
	elif velocity.x > 0:
		sprite.flip_h = false
		attack_hitbox.position.x = attack_hitbox_original_position.x

func _on_attack_hitbox_body_entered(body: Node2D) -> void:
	print(body) # Replace with function body.

func attack_hitbox_disabler(is_active: bool):
	attack_hitbox.get_node("CollisionShape2D").disabled = is_active
