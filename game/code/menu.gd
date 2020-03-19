extends Control

onready var obj = $TextureRect

var _scene = "res://scenes/Level01.tscn"

func _ready():
	pass # Replace with function body.


func _process(_delta):
	if obj.modulate.a <= 0:
		$AudioStreamPlayer2D.stop()
		assert(get_tree().change_scene(_scene) == OK)



func _on_TextureButton_pressed():
	_scene = "res://scenes/Level01.tscn"
	transition_start()

#Credit scene
func _on_TextureButton2_pressed():
	_scene = "res://scenes/Credit.tscn"
	transition_start()

#Game exit
func _on_TextureButton3_pressed():
	_scene = "res://scenes/Level01.tscn"
	get_tree().quit()


func transition_start():
	
	$Tween.interpolate_property(obj, "modulate", Color(1, 1, 1, 1), Color(1, 1, 1, 0), 0.5,
	Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
	


func _on_AudioStreamPlayer2D_finished():
	$AudioStreamPlayer2D.play()
