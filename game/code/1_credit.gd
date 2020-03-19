extends Control
onready var obj = $TextureRect
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(_delta):
	if obj.modulate.a <= 0:
		$AudioStreamPlayer2D.stop()
		assert(get_tree().change_scene("res://scenes/1_menu.tscn") == OK)

func _on_TextureButton_pressed():
	$Tween.interpolate_property(obj, "modulate", Color(1, 1, 1, 1), Color(1, 1, 1, 0), 0.5,
	Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
