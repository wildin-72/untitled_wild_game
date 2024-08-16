extends Node2D

@onready var pause_menu = $Player/CanvasLayer/PlayerUi/PauseMenu
var paused = false
var lvl_complete = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("enter"):
		pause()
	
func pause():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
		paused = !paused
	else:
		pause_menu.show()
		Engine.time_scale = 0
		paused = !paused

func _on_complete_level_body_entered(body):
	if lvl_complete:
		get_tree().reload_current_scene()
	else: 	pass
