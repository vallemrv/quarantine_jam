extends Node2D

onready var HIUD = $HIUD
onready var time_respaw = $time_respaw
onready var Player = $Player

# Called when the node enters the scene tree for the first time.
func _ready():
	HIUD.update_health(100)

func _on_bound_body_entered(body):
	if body.name == "Player":
		game_over()

func _on_Player_die(life):
	if life > 0:
		time_respaw.start()
	else:
		game_over()


func _on_Player_life_modified():
	pass # Replace with function body.

func _on_Player_score_modified():
	pass # Replace with function body.


func _on_Player_take_damage(health):
	HIUD.update_health(health)


func game_over():
	$transition.interpolate_property(self, "modulate", Color(1, 1, 1, 1), Color(1, 1, 1, 0), 0.35,
	Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$transition.start()
	yield(get_tree().create_timer(.5), "timeout")
	if get_tree().reload_current_scene() != OK:
			print_debug("An error occured when trying to reload the current scene at Level.gd.")


func _on_time_respaw_timeout():
	Player.global_position = $respaw.global_position
	Player.respaw()
	HIUD.update_health(Player.HEALTH)
