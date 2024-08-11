extends CharacterBody2D

# This will be changed to whatever the player actually is
@onready var player = get_tree().get_nodes_in_group("Player")[0]
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D
@onready var _animation_player = $Sprite2D/AnimationPlayer
#@onready var hitbox: CollisionShape2D = $Hitbox/CollisionShape2D

var movement_speed: float = 60.0
var distance_in_front_of_player: float = 200.0

# Called when the node enters the scene tree for the first time.
func _ready():
	navigation_agent.path_desired_distance = 4.0
	navigation_agent.target_desired_distance = 4.0
	
	call_deferred("actor_setup")

func actor_setup():
	await get_tree().physics_frame
	
	set_movement_target(Vector2(player.position.x + distance_in_front_of_player, player.position.y))

func set_movement_target(movement_target: Vector2):
	navigation_agent.target_position = movement_target

func check_if_velocity_zero():
	if not velocity.is_zero_approx():
		_animation_player.play("walk")
	elif _animation_player.get_current_animation() == "walk":
		_animation_player.stop()

# How to make punch
# this get's called after navigation_agent is finished
# for now play punch
# enable the hitbox
# then disable the hitbox

func _physics_process(_delta):
	check_if_velocity_zero()
	if navigation_agent.is_navigation_finished():
		# TODO fix this punch attack
		#punch_attack()
		# TODO make it not just return here, continue
		return
	
	# TODO Set movement target less often 
	# this could cause performance issues later
	set_movement_target(Vector2(player.position.x + distance_in_front_of_player, player.position.y))
	
	var current_cultist_position: Vector2 = global_position
	var next_path_position: Vector2 = navigation_agent.get_next_path_position()
	
	velocity = current_cultist_position.direction_to(next_path_position) * movement_speed
	move_and_slide()
