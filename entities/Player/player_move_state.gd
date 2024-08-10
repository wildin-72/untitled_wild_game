extends State

@export var actor : CharacterBody2D
@export var animator : AnimationPlayer
@export var sprite : Sprite2D
@export var hitbox : CollisionShape2D
var player: CharacterBody2D
var input_vector: Vector2

func physics_update(delta):
	input_vector = Vector2(Input.get_axis("ui_left", "ui_right"), Input.get_axis("ui_up", "ui_down")).normalized()
	
	if input_vector:
	#Orient character sprite and hitbox in the direction of input
		if input_vector.x < 0:
			sprite.flip_h = true
			hitbox.position.x = -40
		if input_vector.x > 0:
			sprite.flip_h = false
			hitbox.position.x = 40
		#Set velocity
		actor.velocity = input_vector * actor.SPEED
	else:
		actor.velocity = actor.velocity.move_toward(Vector2.ZERO, actor.SPEED)
	

	actor.move_and_slide()
