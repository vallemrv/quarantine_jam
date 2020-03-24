extends Node

var level = 1
var score = 0
var lives = 0
var health = 0
var show_joystick = true

func get_next_level():
	return "res://scenes/1_level0%s.tscn" % level
