extends State

@export var actor : CharacterBody2D
@export var animator : AnimationPlayer
@export var sprite : Sprite2D
@export var hitbox : Hitbox
var input_vector: Vector2

func enter():
	animator.play("idle")
	
func physics_update(delta):
	input_vector = Vector2(Input.get_axis("ui_left", "ui_right"), Input.get_axis("ui_up", "ui_down")).normalized()
	if input_vector:
		transition.emit(self, "PlayerMoveState")
	if actor.health_changed:
		transition.emit(self, "PlayerHurtState")
	if actor.dead:
		transition.emit(self, "PlayerDeadState")

func _unhandled_input(event):
	if event.is_action_pressed("attack1"):
		transition.emit(self, "PlayerAttack1State")
	if event.is_action_pressed("attack2"):
		transition.emit(self, "PlayerAttack2State")
	if event.is_action_pressed("attack3"):
		transition.emit(self, "PlayerAttack3State")

