extends Node

class_name State

signal Transitioned

var player: CharacterBody2D

func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")

func enter():
	pass
	
func exit():
	pass
	
func update(_delta: float):
	pass
	
func physics_update(_delta: float):
	pass

func update_state_label(label: Label, state: String):
	label.text = state

func _input(event: InputEvent) -> void:
	pass
