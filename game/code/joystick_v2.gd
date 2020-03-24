extends Node2D

signal pressed

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_button_jump_pressed():
	emit_signal("pressed", "jump", true)


func _on_left_pressed():
	emit_signal("pressed", "left_jam", true)



func _on_right_pressed():
	emit_signal("pressed", "right_jam", true)



func _on_left_released():
	emit_signal("pressed", "left_jam", false)



func _on_right_released():
	emit_signal("pressed", "right_jam", false)

