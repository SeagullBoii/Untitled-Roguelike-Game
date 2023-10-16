extends Node
class_name FiniteStateMachine

var states: Dictionary = {}
var previous_state = -1
var state = -1: set = set_state

func _physics_process(delta):
	if state != -1:
		_state_logic(delta)
		var transition = _get_transition()
		if transition != -1:
			set_state(transition)

func _state_logic(_delta: float):
	pass

func _get_transition():
	return -1

func _add_state(new_state: int):
	states[new_state] = states.size()

func set_state(new_state: int):
	_exit_state(state)
	previous_state = state
	state = new_state
	_enter_state(previous_state, state)

func _enter_state(_previous_state: int, _new_state: int):
	pass
	
func _exit_state(_state_exited: int):
	pass
