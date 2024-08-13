extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var animator = $AnimationPlayer
@onready var sprite = $Icon
@onready var hitbox = $Hitbox/CollisionShape2D

@export var flipped: bool = false
@export var health: Health
var health_changed = false
var dead = false
# Get the gravity from the project settings to be synced with RigidBody nodes.



func _on_player_move_state_flipped():
	flipped = true


func _on_player_move_state_unflipped():
	flipped = false



func _on_health_health_depleted():
	dead = true


func _on_hurtbox_received_damage(damage, entity_who_hit):
	if entity_who_hit.is_in_group("Enemy"):
		health.health -= damage
		health_changed = true
		if entity_who_hit.is_in_group("Fireball"):
			entity_who_hit.queue_free()
		await get_tree().create_timer(0.1).timeout
		health_changed = false
