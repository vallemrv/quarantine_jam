extends Path2D

export var time_virus = 5
export var time_vaccine = 10
export (PackedScene) var Virus
export (PackedScene) var Vaccine

onready var position_ran = $position_ram
onready var create_virus = $creator_virus
onready var create_vaccine = $creator_vaccine

var content = null
var is_player_alive = true

func player_die():
	is_player_alive = false
	for node in content.get_children():
		node.queue_free()
	
func player_respaw():
	is_player_alive = true
	
	
# Called when the node enters the scene tree for the first time.
func _ready():
	create_virus.wait_time = time_virus
	create_vaccine.wait_time = time_vaccine
	create_vaccine.start()
	create_virus.start()
	content = get_node("/root/Level01/Viruses")


func _on_creator_timeout():
	if is_player_alive:
		position_ran.set_unit_offset(randf())
		var v = Virus.instance() 
		v.global_position = position_ran.global_position
		content.add_child(v)
	create_virus.start()
	


func _on_creator_vaccine_timeout():
	if is_player_alive:
		position_ran.set_unit_offset(randf())
		var v = Vaccine.instance() 
		v.global_position = position_ran.global_position
		content.add_child(v)
	create_vaccine.start()
