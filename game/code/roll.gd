extends Node2D


export var SCORE = 100


func _ready():
	pass # Replace with function body.


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		body.take_roll(SCORE)
		queue_free()
