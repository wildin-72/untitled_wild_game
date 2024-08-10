extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var animator = $AnimationPlayer
@onready var sprite = $Icon
@onready var hitbox = $Hitbox/CollisionShape2D

# Get the gravity from the project settings to be synced with RigidBody nodes.




func _unhandled_input(event):
	if event.is_action_pressed("attack1"):
		animator.play("attack1")
