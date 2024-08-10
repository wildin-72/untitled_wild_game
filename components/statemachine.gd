extends Node
class_name StateMachine

@export var initial_state : State 


#Track current state and create dictionary with file names as keys and scripts as values
var current_state : State
var states : Dictionary = {}

#Check for states among children nodes
func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.transition.connect(on_state_transition)
	#Apply initial state
	if initial_state:
		initial_state.enter()
		current_state = initial_state

#Process state's process code every process frame
func _process(delta):
	if current_state:
		current_state.update(delta)
	
#Process state's physics code every physics frame
func _physics_process(delta):
	if current_state:
		current_state.physics_update(delta)


func on_state_transition(current_state_name, new_state_name):
	#Check if correct state is calling transition
	if current_state_name != current_state:
		return
	#Check for new state name in dictionary 
	var transitioning_to = states.get(new_state_name.to_lower())
	if !transitioning_to:
		return
	#Check if current state, if true, call exit on current state
	if current_state:
		current_state.exit()
	#Call enter on state we are transitioning to and update current_state tracker
	transitioning_to.enter()
	current_state = transitioning_to
	
	
	
		
	
	
	 
