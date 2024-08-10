extends Area2D

#onready var player: Node = get_tree().get_nodes_in_group("Player")[0]

# scans area for player


# if player is seen, walk towards location

# if player is *in front* of enemy, do attack 
# right now I will indicate by changing the color



# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("Cultist")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
