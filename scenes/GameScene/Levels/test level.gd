extends Node2D

var current_wave: int
@export var enemy_scene: PackedScene


var current_nodes: int
var start_nodes: int
var wave_end



# Called when the node enters the scene tree for the first time.
func _ready():
	current_wave = 0
	current_nodes = get_child_count()
	start_nodes = get_child_count()
	pos_to_next_wave()

	
func pos_to_next_wave():
	if current_nodes == start_nodes: #if no enemies
		current_wave += 1
		await get_tree().create_timer(0.5).timeout
		prepare_spawn("cultist", 2, 1.5) #type, mult, num_spawns
		print(current_wave)

func prepare_spawn(type, mult, num_spawns):
		var mob_amount = float(current_wave) * mult
		var mob_wait_time: float = 2.0
		print("mob_amount: ", mob_amount)
		var mob_spawn_rounds = mob_amount/num_spawns
		spawn_type(type, mob_spawn_rounds, mob_wait_time)
		
func spawn_type(type, mob_spawn_rounds, mob_wait_time):
	if mob_spawn_rounds >= 1:
		for i in mob_spawn_rounds:
			var enemy1 = enemy_scene.instantiate()
			enemy1.global_position = $EnemySpawn.global_position
			var enemy2 = enemy_scene.instantiate()
			enemy2.global_position = $EnemySpawn2.global_position
			add_child(enemy1)
			add_child(enemy2)
			mob_spawn_rounds -= 1
			await get_tree().create_timer(mob_wait_time).timeout
	wave_end = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
		
