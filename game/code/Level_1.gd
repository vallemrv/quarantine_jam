extends Node2D

export (PackedScene) var Virus


onready var player = $Player
# Called when the node enters the scene tree for the first time.


func _ready():
	randomize()


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
