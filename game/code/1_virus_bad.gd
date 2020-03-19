extends KinematicBody2D

onready var raycast = $RayCast2D
onready var time_onshot = $time_onshot


export var GRAVITY = 1000
export var SPEED = 100
export var DAMAGE = 20
export var POINT = 100

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
		time_onshot.start()
		
	if is_on_wall() and not _just_touch:
		_dir *= -1
		_just_touch = true
		time_onshot.start()
		
	_velocity = move_and_slide(_velocity, Vector2.UP)


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		_velocity = Vector2.ZERO
		$Area2D/CollisionShape2D.call_deferred("disabled", true)	
		if body.vulnerable:
			body.take_damage(DAMAGE)
			$AnimationPlayer.play("attack")
		else:
			body.take_score(POINT)
			$AnimationPlayer.play("die")


func _on_time_life_timeout():
	queue_free()


func _on_time_onshot_timeout():
	_just_touch = false
	
