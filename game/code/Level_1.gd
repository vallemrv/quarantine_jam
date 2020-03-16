extends Node2D

export (PackedScene) var Virus


onready var player = $Player
onready var position_ran = $Player/position_virus/position_ram
onready var create_virus = $Timers/create_virus
# Called when the node enters the scene tree for the first time.


var _limite_visible = Vector2.ZERO


func _ready():
	randomize()
	create_virus.start()
	_limite_visible = get_viewport_rect().size



func _on_Area2D_body_entered(body):
	if body.name == "Player":
		body.player_die()


func _on_Player_die():
	yield(get_tree().create_timer(.5), "timeout")
	$transition.interpolate_property(self, "modulate", Color(1, 1, 1, 1), Color(1, 1, 1, 0), 0.35,
	Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$transition.start()
	yield(get_tree().create_timer(.5), "timeout")
	if get_tree().reload_current_scene() != OK:
			print_debug("An error occured when trying to reload the current scene at Level.gd.")



func _on_Timer_timeout():
	pass


func _on_create_virus_timeout():
	position_ran.set_unit_offset(randf())
	var v = Virus.instance() 
	v.global_position = position_ran.global_position
	add_child(v)
	#v.set_linear_velocity(Vector2(rand_range(v.SPEED_MIN, v.SPEED_MAX), 1))
	create_virus.start()
	print("now")
