extends Control

onready var obj = $img_rect

var _scene = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(_delta):
	if obj.modulate.a <= 0:
		assert(get_tree().change_scene(_scene) == OK)


func _on_play_pressed():
	_scene = "res://scenes/Level01.tscn"
	make_transition()

func _on_exit_pressed():
	_scene = "res://scenes/Menu.tscn"
	make_transition()

func make_transition():
	$Tween.interpolate_property(obj, "modulate", Color(1, 1, 1, 1), Color(1, 1, 1, 0), 0.5,
	Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
