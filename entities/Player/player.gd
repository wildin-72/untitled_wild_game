extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var animator = $AnimationPlayer
@onready var sprite = $Icon
@onready var hitbox = $Hitbox/CollisionShape2D

@export var flipped: bool = false
# Get the gravity from the project settings to be synced with RigidBody nodes.

func _on_player_move_state_flipped():
	flipped = true


func _on_player_move_state_unflipped():
	flipped = false
