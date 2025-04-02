extends CharacterBody2D

class_name Player

@onready var sprite: Sprite2D = $Sprite
@onready var state_label: Label = $StateLabel
@onready var attack_hitbox: Area2D = $AttackHitbox
@onready var attack_hitbox_original_position = attack_hitbox.position

@export var speed: int = 100
@export var jump_velocity: int = -250
@export var acceleration: float = 500
@export var friction: float = 490

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction: Vector2 = Vector2(0, 1)

func _ready() -> void:
	attack_hitbox_disabler(true)

func _physics_process(delta: float) -> void:
	state_label.global_position = self.global_position
	move_player(delta)
	move_and_slide()

func move_player(delta) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
		
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	flip_player()
	
func flip_player():
	if velocity.x < 0:
		sprite.flip_h = true
		attack_hitbox.position.x = -attack_hitbox_original_position.x
	elif velocity.x > 0:
		sprite.flip_h = false
		attack_hitbox.position.x = attack_hitbox_original_position.x

func _input(event: InputEvent) -> void:
	if is_on_floor():
		if event.is_action_pressed("jump"):
			velocity.y = jump_velocity
			
func attack_hitbox_disabler(is_active: bool):
	attack_hitbox.get_node("CollisionShape2D").disabled = is_active


func _on_attack_hitbox_body_entered(body: Node2D) -> void:
	print(body)
