extends KinematicBody2D

signal die
signal take_damage
signal health_modified
signal score_modified
signal life_modified


onready var img = $sprite
onready var animation = $AnimationPlayer

export var  GRAVITY = 1500
export var  SPEED = 280
export var  JUMP_FORCE = -600
export var  LIVES = 3
export var  HEALTH = 100


var _jump_moment = 0;
var _velocity = Vector2.ZERO
var _can_double_jump = false
var _is_jump = false
var _health = HEALTH
var _lives = LIVES

func take_damage(damage):
	_health -= damage
	if _health > 0:
		emit_signal("take_damage")
	else:
		emit_signal("die")
	print(_health)

func _ready():
	_jump_moment = JUMP_FORCE
	
func _animation():
	if is_on_floor() and _velocity.x == 0:
		animation.play("idle")
	elif is_on_floor() and _velocity.x != 0:
		animation.play("run")
	elif _is_jump:
		animation.stop()
		animation.play("jump")
		_is_jump = false

func get_input():

	if Input.is_action_pressed("right_jam"):
		_velocity.x = SPEED
		if img.get_scale().x < 0:
			img.set_scale(img.get_scale()*Vector2(-1,1))
	elif Input.is_action_pressed("left_jam"):
		_velocity.x = -SPEED
		if img.get_scale().x > 0:
			img.set_scale(img.get_scale()*Vector2(-1,1))
	else:
		_velocity.x = 0
		
	if Input.is_action_just_pressed("up_jam") and (is_on_floor() or not _can_double_jump):
		_velocity.y = _jump_moment
		_is_jump = true
		if not _can_double_jump:
			_can_double_jump = true
		
	if is_on_floor():
		_can_double_jump = false
	
	
func _physics_process(delta):
	_velocity.y += GRAVITY * delta
	get_input()
	_animation()
	_velocity = move_and_slide(_velocity, Vector2.UP)
	


func player_die():
	queue_free()
	emit_signal("die")
