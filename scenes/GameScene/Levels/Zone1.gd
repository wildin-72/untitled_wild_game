extends Area2D

@onready var init_cam = $"../Player/Camera2D"
@onready var player_cam = $"../Player/Camera2D"
@onready var zone_cam = $ZoneCam
@onready var barriers = $ZoneBarrier.get_children()
@onready var num_enemies = $EnemyHolder.get_child_count()
@onready var enemy_basic = preload("res://entities/Cultist/Basic/cultist_basic.tscn")
@onready var enemy_projectile = preload("res://entities/Cultist/Projectile/cultist_projectile.tscn")
@onready var wave_num: = 0
var zone_active = false


# Called when the node enters the scene tree for the first time.
func _ready():
	for barrier in barriers:
		barrier.disabled = true
	zone_active = false

func _on_body_entered(body):
	if body == $"../Player":
		print("test") #zone activates once player steps inside
		zone_active = true
	
func next_wave():
	if num_enemies == 0: #goes to next wave
		wave_num += 1
		if wave_num == 2:
			zone_active = false
			$ZoneBarrier/CollisionShape2D2.disabled = true
		else:
			prepare_spawn("basic", 2, 2)
			prepare_spawn("proj", .5, 1)

		
func prepare_spawn(type, mult, mob_spawns):
	var mob_amount = wave_num*mult
	var mob_wait_time = 2.0
	var mob_spawn_rounds = float(mob_amount/mob_spawns)
	spawn_enemies(type, mob_spawn_rounds, mob_wait_time)

func spawn_enemies(type, mob_spawn_rounds, mob_wait_time):
	if type == "basic":
		if mob_spawn_rounds >= 1:
			for i in mob_spawn_rounds:
				var basic1 = enemy_basic.instantiate()
				var basic2 = enemy_basic.instantiate()
				basic1.global_position = $EnemySpawn.global_position
				basic2.global_position = $EnemySpawn2.global_position
				$EnemyHolder.add_child(basic1)
				$EnemyHolder.add_child(basic2)
				mob_spawn_rounds -= 1
				await get_tree().create_timer(mob_wait_time).timeout
				
	if type == "proj":
		if mob_spawn_rounds >= 1:
			for i in mob_spawn_rounds:
				var proj = enemy_projectile.instantiate()
				proj.global_position = $EnemySpawn3.global_position
				$EnemyHolder.add_child(proj)
				mob_spawn_rounds -= 1
				await get_tree().create_timer(mob_wait_time).timeout
				

func _on_body_exited(body):
	if body == $"../Player":
		$ZoneBarrier/CollisionShape2D2.set_deferred("disabled", false)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if zone_active:
		for barrier in barriers:
			barrier.disabled = false
		zone_cam.make_current()
		num_enemies = $EnemyHolder.get_child_count()
		print("wave_num ", wave_num, " num enemies ", num_enemies)
		next_wave()
		
	if zone_active == false:
		player_cam.make_current()
		



