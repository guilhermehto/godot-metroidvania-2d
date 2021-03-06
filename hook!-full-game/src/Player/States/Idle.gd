extends State


onready var jump_delay: Timer = $JumpDelay


func _setup() -> void:
	# force update once at start of game
	var move: = get_parent()
	owner.move_and_slide(move.velocity, owner.FLOOR_NORMAL)


func unhandled_input(event: InputEvent) -> void:
	get_parent().unhandled_input(event)


func physics_process(delta: float) -> void:
	if owner.is_on_floor() and get_parent().get_move_direction().x != 0.0:
		_state_machine.transition_to("Move/Run")
	elif not owner.is_on_floor():
		_state_machine.transition_to("Move/Air")


func enter(msg: Dictionary = {}) -> void:
	var move = get_parent()
	move.speed = move.XY_MAX_SPEED
	move.velocity = Vector2.ZERO
	if jump_delay.time_left > 0.0:
		move.velocity = move.calculate_velocity(
				move.velocity, move.speed, Vector2(0.0, move.JUMP_SPEED), 1.0, Vector2.UP)
		_state_machine.transition_to("Move/Air")
