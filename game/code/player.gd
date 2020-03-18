extends KinematicBody2D

signal die
signal take_damage
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
var _is_hurt = false


func respaw():
	_health = HEALTH
	$position_virus.player_respaw()
	set_physics_process(true)
	visible = true
	
func take_damage(damage):
	_health -= damage
	_is_hurt = true
	if _health > 0:
		emit_signal("take_damage", _health)
	else:
		player_die()
	

func _ready():
	_jump_moment = JUMP_FORCE
	
func _animation():
	if is_on_floor() and _velocity.x != 0:
		animation.play("run")
	elif _is_jump:
		animation.stop()
		animation.play("jump")
		_is_jump = false
	elif _is_hurt:
		animation.play("hurt")
	elif is_on_floor() and _velocity.x == 0:
		animation.play("idle")

func get_input():
	if Input.is_action_pressed("right_jam") and not _is_hurt:
		_velocity.x = SPEED
		if img.get_scale().x < 0:
			img.set_scale(img.get_scale()*Vector2(-1,1))
	elif Input.is_action_pressed("left_jam") and not _is_hurt:
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
	set_physics_process(false)
	visible = false
	$position_virus.player_die()
	emit_signal("die", _lives)


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "hurt":
		_is_hurt = false
