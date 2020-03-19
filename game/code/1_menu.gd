extends Control

onready var obj = $TextureRect

var _scene = "res://scenes/1_level01.tscn"

func _ready():
	pass # Replace with function body.


func _process(_delta):
	if obj.modulate.a <= 0:
		$AudioStreamPlayer2D.stop()
		assert(get_tree().change_scene(_scene) == OK)



func transition_start():
	
	$Tween.interpolate_property(obj, "modulate", Color(1, 1, 1, 1), Color(1, 1, 1, 0), 0.5,
	Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
	


func _on_AudioStreamPlayer2D_finished():
	$AudioStreamPlayer2D.play()


func _on_button_exit_pressed():
	get_tree().quit()


func _on_button_credit_pressed():
	_scene = "res://scenes/1_credit.tscn"
	transition_start()


func _on_button_game_pressed():
	_scene = "res://scenes/1_level01.tscn"
	transition_start()

