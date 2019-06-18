extends "res://src/Player/States/State.gd"
"""
Moves the player freely around the world, ignoring collisions.
This state has its own movement code so it doesn't depend on or mess with the Move state
Use the move_* input to move the character, or click
debug_sprint, assigned to Shift on the keyboard and B on an XBOX controller, moves the character faster
"""

var velocity: = Vector2.ZERO setget set_velocity
const speed: = Vector2(600.0, 600.0)

func setup(player: KinematicBody2D, state_machine: Node) -> void:
	.setup(player, state_machine)


func unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed('toggle_debug_move'):
		_state_machine.transition_to('Move/Air', {'velocity': Vector2.ZERO})
	if event.is_action_pressed('click'):
		_player.position += _player.get_local_mouse_position()


func physics_process(delta: float) -> void:
	var direction: = get_move_direction()
	var multiplier: = 3.0 if Input.is_action_pressed('debug_sprint') else 1.0
	self.velocity = speed * direction * multiplier
	_player.position += velocity * delta


func enter(msg: Dictionary = {}):
	_player.active = false


func exit():
	_player.active = true


func set_velocity(value: Vector2) -> void:
	if _player == null:
		return
	
	velocity = value
	_player.info_dict.velocity = velocity


static func get_move_direction() -> Vector2:
	return Vector2(
			Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
			Input.get_action_strength("move_down") - Input.get_action_strength("move_up"))