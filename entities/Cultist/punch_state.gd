extends State

@export var cultist : CharacterBody2D
@export var sprite : Sprite2D
@export var animator : AnimationPlayer
@export var hitbox : CollisionShape2D

func enter():
	punch()

func punch():
	cultist.velocity = Vector2(0,0)
	if cultist.flipped == true:
		hitbox.position.x = abs(hitbox.position.x)
	else:
		hitbox.position.x = -abs(hitbox.position.x)
	hitbox.disabled = false
	animator.play("punch")
	await get_tree().create_timer(0.75).timeout
	print("Punch done")
	hitbox.disabled = true
	animator.stop()
	transition.emit(self, "Move")
	
