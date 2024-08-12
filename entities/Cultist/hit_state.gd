extends State

@export var cultist : CharacterBody2D
@onready var player = get_tree().get_nodes_in_group("Player")[0]

func enter():
	knockback()
	await get_tree().create_timer(1).timeout
	transition.emit(self, "Move")

func knockback():
	if cultist.position.x > player.position.x:
		cultist.velocity.x = -60
	elif cultist.position.x < player.position.x:
		cultist.velocity.x = 60

