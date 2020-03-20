extends TouchScreenButton

var radius = Vector2(27,27)
var bundary = 52

func get_button_pos():
	return position - radius
	
func _input(event):
	if event is InputEventScreenDrag or (event is InputEventScreenTouch and event.is_pressed()):
		global_position = event.position - radius * global_scale
		
		if get_button_pos().length() > bundary:
			position = (get_button_pos().normalized() * bundary) - radius 
