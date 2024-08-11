extends State

@export var cultist : CharacterBody2D
@export var animator : AnimationPlayer

func enter():
	charge_punch()

func charge_punch():
	animator.play("charge_punch")
	await get_tree().create_timer(0.5).timeout
	transition.emit(self, "Punch")
