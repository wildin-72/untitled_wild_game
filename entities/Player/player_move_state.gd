extends State

@export var actor : CharacterBody2D
@export var animator : AnimationPlayer
@export var sprite : Sprite2D
@export var hitbox : Hitbox
var input_vector: Vector2

signal flipped
signal unflipped

func physics_update(delta):
	input_vector = Vector2(Input.get_axis("ui_left", "ui_right"), Input.get_axis("ui_up", "ui_down")).normalized()
	
	if input_vector:
	#Orient character sprite and hitbox in the direction of input, 
	#sends signal to Player to set its "flipped" bool 
		if input_vector.x < 0:
			sprite.flip_h = true
			emit_signal("flipped")
		if input_vector.x > 0:
			sprite.flip_h = false
			emit_signal("unflipped")
		#Set velocity
		actor.velocity = input_vector * actor.SPEED
	else:
		actor.velocity = actor.velocity.move_toward(Vector2.ZERO, actor.SPEED)
	actor.move_and_slide()


func _unhandled_input(event):
	if event.is_action_pressed("attack1"):
		transition.emit(self, "PlayerAttack1State")
	if event.is_action_pressed("attack2"):
		transition.emit(self, "PlayerAttack2State")
	if event.is_action_pressed("attack3"):
		transition.emit(self, "PlayerAttack3State")
