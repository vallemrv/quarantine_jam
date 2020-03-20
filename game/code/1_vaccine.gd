extends RigidBody2D

export var wait_live = 4

# Called when the node enters the scene tree for the first time.
func _ready():
	$timer_live.wait_time = wait_live
	$timer_live.start()

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		body.set_invulnerable()
		queue_free()

func _on_timer_live_timeout():
	queue_free()
