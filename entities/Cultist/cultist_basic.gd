extends CharacterBody2D

# This will be changed to whatever the player actually is
@onready var player = get_tree().get_nodes_in_group("Player")[0]
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D

var movement_speed: float = 200.0


# if player is *in front* of enemy, do attack 
# right now I will indicate by changing the color



# Called when the node enters the scene tree for the first time.
func _ready():
	navigation_agent.path_desired_distance = 4.0
	navigation_agent.target_desired_distance = 4.0
	
	call_deferred("actor_setup")

func actor_setup():
	await get_tree().physics_frame
	
	set_movement_target(player.position)

func set_movement_target(movement_target: Vector2):
	navigation_agent.target_position = movement_target

func _physics_process(delta):
	if navigation_agent.is_navigation_finished():
		return
	
	var current_cultist_position: Vector2 = global_position
	var next_path_position: Vector2 = navigation_agent.get_next_path_position()
	
	velocity = current_cultist_position.direction_to(next_path_position) * movement_speed
	move_and_slide()
