extends Path2D

export var time = 5
export (PackedScene) var Virus

onready var position_ran = $position_ram
onready var create_virus = $creator

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
	$creator.wait_time = time
	$creator.start()
	content = get_node("/root/Level01/Viruses")


func _on_creator_timeout():
	if is_player_alive:
		position_ran.set_unit_offset(randf())
		var v = Virus.instance() 
		v.global_position = position_ran.global_position
		content.add_child(v)
	create_virus.start()
	
