extends Path2D

export var time = 5
export (PackedScene) var Virus

onready var position_ran = $position_ram
onready var create_virus = $creator

# Called when the node enters the scene tree for the first time.
func _ready():
	$creator.wait_time = time
	$creator.start()


func _on_creator_timeout():
	position_ran.set_unit_offset(randf())
	var v = Virus.instance() 
	v.global_position = position_ran.global_position
	get_tree().root.add_child(v)
	create_virus.start()
	
