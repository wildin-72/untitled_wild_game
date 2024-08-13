extends State

@export var cultist : CharacterBody2D

func enter():
	cultist.queue_free()
