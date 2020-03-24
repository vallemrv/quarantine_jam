extends Sprite

signal pressed


func _on_button_jump_pressed():
	emit_signal("pressed", "jump", true)



func _on_joystick_movement(value, is_press):
	emit_signal("pressed", value, is_press)

