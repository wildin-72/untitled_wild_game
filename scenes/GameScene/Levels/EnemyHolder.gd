extends Node

@onready var num_enemies = get_child_count()
@onready var enemy_basic = preload("res://entities/Cultist/Basic/cultist_basic.tscn")
@onready var enemy_projectile = preload("res://entities/Cultist/Projectile/cultist_projectile.tscn")
var spawn_end


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func next_wave():
	if num_enemies == 0:
		spawn_enemies()

		
func spawn_enemies():
	var enemy1 = enemy_basic.instantiate()
	var enemy2 = enemy_projectile.instantiate()
	enemy1.position = get_parent().get_node("EnemySpawn").position
	enemy2.position = get_parent().get_node("EnemySpawn2").position
	add_child(enemy1)
	add_child(enemy2)
	await get_tree().create_timer(.5).timeout



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	num_enemies = get_child_count()
	next_wave()
