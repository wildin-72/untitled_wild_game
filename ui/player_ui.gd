extends Control

@export var actor = CharacterBody2D
@onready var health_bar = $Control/HealthBar
@onready var sanity_bar = $Control/SanityBar

func ready():
	global_position = Vector2(0,0)



func _on_hurtbox_received_damage(damage, owner):
	health_bar.frame = actor.health.max_health - actor.health.health


func _on_hurtbox_received_health(health):
	health_bar.frame = actor.health.max_health - actor.health.health
