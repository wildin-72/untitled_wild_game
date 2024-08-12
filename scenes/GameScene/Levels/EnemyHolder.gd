extends Node

@onready var num_enemies = get_child_count()
@onready var enemy = preload("res://entities/Cultist/cultist_basic.tscn")
var spawn_end


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func next_wave():
	if num_enemies == 0:
		spawn_enemies()

		
func spawn_enemies():
	var enemy1 = enemy.instantiate()
	var enemy2 = enemy.instantiate()
	enemy1.position = get_parent().get_node("EnemySpawn").position
	enemy2.position = get_parent().get_node("EnemySpawn2").position
	add_child(enemy1)
	add_child(enemy2)
	await get_tree().create_timer(.5).timeout



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	num_enemies = get_child_count()
	print(spawn_end)
	next_wave()
