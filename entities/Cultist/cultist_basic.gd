extends CharacterBody2D

# This will be changed to whatever the player actually is
@onready var player = get_tree().get_nodes_in_group("Player")[0]
@onready var animator = $Sprite2D/AnimationPlayer
@onready var sprite = $Sprite2D
@onready var navigation_agent = $NavigationAgent2D
#@onready var hitbox: CollisionShape2D = $Hitbox/CollisionShape2D
@export var flipped : bool = false

func _on_cultist_move_state_flipped():
	flipped = true

func _on_cultist_move_state_unflipped():
	flipped = false
