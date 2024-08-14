extends State


@export var animator : AnimationPlayer

signal transformed

func enter():
	animator.play("transform")
	await animator.animation_finished
	emit_signal("transformed")
	transition.emit(self, "PlayerIdleState")
	

