extends State

onready var duration: Timer = $Duration

func enter(msg: Dictionary = {}):
	duration.start()
	yield(duration, "timeout")
	_state_machine.transition_to("Move/Idle")
