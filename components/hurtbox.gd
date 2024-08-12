class_name Hurtbox
extends Area2D

#Signal is emitted when a hitbox object in group "enemy" is detected,
#sends the "damage" value stored in that hitbox object 
#note: the signal is not connected to any function by default
signal received_damage(damage: int)

#Plug in health object in the inspector, 
#damage will be subtracted from the values stored in this object
@export var health: Health

var collision_shape: CollisionShape2D
var invulnerability_timer: InvulnTimer

func _ready():
	connect('area_entered', _on_area_entered)
	for child in self.get_children():
		if child is InvulnTimer:
			invulnerability_timer = child
		if child is CollisionShape2D:
			collision_shape = child
	assert(collision_shape != null, "ERROR: You must assign a CollisionShape to this Hurtbox Object.");

#This function is called when this node's "area_entered" signal is emitted.
#It checks if the area that is entering it is a Hitbox object,
#If so, it then checks if the hitbox has a parent (i.e. is not a "stray" hitbox)
#If so, then it takes the damage value stored in that Hitbox object and subtracts
#the connected Health object's health value by that amount
func _on_area_entered(area: Area2D) -> void:
	#print("player hurtbox entered")
	if area is Hitbox:
		print("PLAYER HIT")
		var hitbox = area as Hitbox
		if hitbox and hitbox.owner:
			#Collect hitbox data
			var damage = hitbox.damage
			#Apply damage to the health value stored in the export variable
			if damage > 0:
				health.health -= hitbox.damage
				received_damage.emit(hitbox.damage)
	if invulnerability_timer:
		invulnerability_timer.run()


