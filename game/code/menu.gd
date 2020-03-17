extends Control

onready var obj = $TextureRect


func _ready():
	pass # Replace with function body.


func _process(_delta):
	if obj.modulate.a <= 0:
		assert(get_tree().change_scene("res://scenes/Level01.tscn") == OK)



func _on_TextureButton_pressed():
	$Tween.interpolate_property(obj, "modulate", Color(1, 1, 1, 1), Color(1, 1, 1, 0), 0.5,
	Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
