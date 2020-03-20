extends TouchScreenButton


var radius = Vector2(27,27)
var boundary = 53

var ongoing_drag = -1
var return_accel = 20
var threshold = 20

func _process(delta):
	if ongoing_drag == -1:
		var pos_difference = (Vector2.ZERO - radius) - position
		position += pos_difference * return_accel * delta

func get_button_pos():
	return position + radius
	
func _input(event):
	if event is InputEventScreenDrag or (event is InputEventScreenTouch and event.is_pressed()):
		var event_dist_from_centre = (event.position - get_parent().global_position).length()
		
		if event_dist_from_centre <= boundary * global_scale.x  or event.get_index() == ongoing_drag:
			global_position = event.position - radius * global_scale
			if get_button_pos().length() > boundary:
				position = (get_button_pos().normalized() * boundary) - radius 
			ongoing_drag = event.get_index()
	if event is InputEventScreenTouch and !event.is_pressed() and event.get_index() == ongoing_drag:
		ongoing_drag = -1


func get_value():
	if get_button_pos().length() > threshold:
		return get_button_pos().normalized()
	return Vector2.ZERO

