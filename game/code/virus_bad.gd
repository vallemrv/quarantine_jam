extends KinematicBody2D

onready var raycast = $RayCast2D

export var GRAVITY = 1000
export var SPEED = 100
export var DAMAGE = 20

var _just_touch = false
var _velocity = Vector2.ZERO
var _dir = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	_velocity.y += GRAVITY * delta
	_velocity.x = _dir * SPEED 
	
	if not raycast.is_colliding() and not _just_touch:
		_dir *= -1
		_just_touch = true
		yield(get_tree().create_timer(0.5), "timeout")
		_just_touch = false
		
	if is_on_wall() and not _just_touch:
		_dir *= -1
		_just_touch = true
		yield(get_tree().create_timer(0.5), "timeout")
		_just_touch = false
	
	_velocity = move_and_slide(_velocity, Vector2.UP)


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		body.take_damage(DAMAGE)
