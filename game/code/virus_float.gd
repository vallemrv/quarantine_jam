extends RigidBody2D


export var SPEED_MAX = 150
export var SPEED_MIN = 100
export var DAMAGE = 10

var _velocity = Vector2.ZERO
var _dir = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	pass

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		body.take_damage(DAMAGE)
		queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	print("caraculo")


func _on_time_life_timeout():
	queue_free()
