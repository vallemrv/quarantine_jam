extends Node2D

onready var HIUD = $HIUD
onready var time_respaw = $time_respaw
onready var Player = $Player
onready var count_asset = $count_asset


# Called when the node enters the scene tree for the first time.
func _ready():
	HIUD.update_health(100)
	HIUD.update_info_roll($Asset.get_child_count())

func _on_bound_body_entered(body):
	if body.name == "Player":
		body.player_die()

func _on_Player_die(life):
	if life > -1:
		HIUD.update_lifes(life)
		time_respaw.start()
	else:
		game_over()



func _on_Player_take_damage(health):
	HIUD.update_health(health)


func game_over():
	$transition.interpolate_property(self, "modulate", Color(1, 1, 1, 1), Color(1, 1, 1, 0), 0.35,
	Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$transition.start()
	yield(get_tree().create_timer(.5), "timeout")
	if get_tree().change_scene("res://scenes/game_over.tscn") != OK:
			print_debug("An error occured when trying to reload the current scene at Level.gd.")


func _on_time_respaw_timeout():
	Player.global_position = $respaw.global_position
	Player.respaw()
	HIUD.update_health(Player.HEALTH)


func _on_Player_take_score(score):
	HIUD.update_score(score)


func _on_Player_take_roll(score):
	HIUD.update_score(score)
	count_asset.start()


func _on_count_asset_timeout():
	HIUD.update_info_roll($Asset.get_child_count())

