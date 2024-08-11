extends State

@onready var player = get_tree().get_nodes_in_group("Player")[0]
@export var cultist : CharacterBody2D
@export var animator : AnimationPlayer
@export var sprite : Sprite2D
@export var navigation_agent : NavigationAgent2D

signal flipped
signal unflipped

var movement_speed: float = 60.0
var distance_in_front_of_player: float = 100.0

func enter():
	print("Entering Move State")
	navigation_agent.path_desired_distance = 4.0
	navigation_agent.target_desired_distance = 4.0
	
	call_deferred("actor_setup")

func actor_setup():
	await get_tree().physics_frame
	
	set_movement_target(Vector2(player.position.x + distance_in_front_of_player, player.position.y))

func set_movement_target(movement_target: Vector2):
	navigation_agent.target_position = movement_target

func check_if_velocity_zero():
	if not cultist.velocity.is_zero_approx():
		sprite.position.x = 0
		animator.play("walk")
	elif animator.get_current_animation() == "walk":
		animator.stop()

# How to make punch
# this get's called after navigation_agent is finished
# for now play punch
# enable the hitbox
# then disable the hitbox

func physics_update(_delta):
	check_if_velocity_zero()
	if navigation_agent.is_navigation_finished():
		animator.stop()
		transition.emit(self, "Charge")
		return
	
	# TODO Set movement target less often 
	# this could cause performance issues later
	
	
	# Check if player X compared to cultist is negative or positive
	# Change flipped state based on this
	if player.position.x > cultist.position.x:
		sprite.flip_h = true
		emit_signal("flipped")
		set_movement_target(Vector2(player.position.x - distance_in_front_of_player, player.position.y))
	else:
		sprite.flip_h = false
		emit_signal("unflipped")
		set_movement_target(Vector2(player.position.x + distance_in_front_of_player, player.position.y))
	
	var current_cultist_position: Vector2 = cultist.global_position
	var next_path_position: Vector2 = navigation_agent.get_next_path_position()
	
	cultist.velocity = current_cultist_position.direction_to(next_path_position) * movement_speed
	cultist.move_and_slide()
