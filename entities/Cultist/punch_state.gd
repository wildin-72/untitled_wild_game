extends State

@export var cultist : CharacterBody2D
@export var animator : AnimationPlayer
@export var hitbox : CollisionShape2D

func enter():
	punch()

func punch():
	cultist.velocity = Vector2(0, 0)
	hitbox.disabled = false
	animator.play("punch")
	await get_tree().create_timer(0.75).timeout
	print("Punch done")
	hitbox.disabled = true
	animator.stop()
	transition.emit(self, "Move")
	
