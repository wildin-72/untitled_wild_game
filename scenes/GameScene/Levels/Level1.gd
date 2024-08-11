extends Node

@export var cultist_scene: PackedScene

# For spawning cultist enemy on screen
func spawn_cultist():
	var cultist = cultist_scene.instantiate()
	
	# TODO make more randomized?
	var cultist_spawn_location = $CultistPosition.position
	cultist.position = cultist_spawn_location
	
	add_child(cultist)

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_cultist()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
