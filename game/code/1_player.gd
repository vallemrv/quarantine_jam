extends KinematicBody2D



signal die
signal take_damage
signal take_score
signal take_roll


onready var img = $sprite
onready var animation = $AnimationPlayer
onready var raycast = $sprite/RayCast2D
onready var out_vulnerability = $out_vulnerability
onready var aura = $aura
onready var hurt_play = $sounds/hurt_effect
onready var inmunity_effect = $sounds/imunity_effect
onready var jump_effect = $sounds/jump_effect
onready var hit_effect = $sounds/hit_effect



export var  GRAVITY = 1500
export var  SPEED = 280
export var  JUMP_FORCE = -600
export var  LIVES = 3
export var  HEALTH = 100
export var  VULNERABIlILTY = 10

var score = 0
var health = HEALTH
var lives = LIVES
var vulnerable = true

var _jump_moment = 0;
var _velocity = Vector2.ZERO
var _can_double_jump = false
var _is_jump = false
var _is_hurt = false
var _is_die = false
var _is_killer = false
var _value_movement = ""
var _value_jump = false
var _joystick_jump_pressed = false


func set_invulnerable():
	aura.visible = true
	aura.playing = true
	vulnerable = false
	inmunity_effect.play()
	out_vulnerability.start()

func respaw():
	health = HEALTH
	$position_virus.player_respaw()
	_is_die = false
	visible = true

func take_roll(_score):
	score += _score
	emit_signal("take_roll", score)
	
func take_score(_score):
	score += _score
	emit_signal("take_score", score)
		
func take_damage(damage):
	hurt_play.play()
	if not _is_die:
		health -= damage
		_is_hurt = true
		if health > -1:
			emit_signal("take_damage", health)
		else:
			player_die()
	

func _ready():
	_jump_moment = JUMP_FORCE
	out_vulnerability.wait_time = VULNERABIlILTY
	
func _animation():
	if _is_killer:
		animation.play("killer")
		#hit_effect.play()
	elif _is_jump:
		animation.stop()
		animation.play("jump")
		_is_jump = false
	elif _is_hurt:
		animation.play("hurt")
	elif is_on_floor() and _velocity.x != 0:
		animation.play("run")
	elif is_on_floor() and _velocity.x == 0:
		animation.play("idle")
	
func set_value_joystick(value):
	if value.x > 0:
		_value_movement = "right_jam"
	elif value.x < 0:
		_value_movement = "left_jam"
	else:
		_value_movement = ""
		
func jump():
	_joystick_jump_pressed = true
	
func get_input():
	if _value_movement == "right_jam" or  Input.is_action_pressed("right_jam") and not _is_hurt :
		_velocity.x = SPEED
		if img.get_scale().x < 0:
			img.set_scale(img.get_scale()*Vector2(-1,1))
	elif  _value_movement == "left_jam" or Input.is_action_pressed("left_jam") and not _is_hurt :
		_velocity.x = -SPEED
		if img.get_scale().x > 0:
			img.set_scale(img.get_scale()*Vector2(-1,1))
	else:
		_velocity.x = 0
		
	if (_joystick_jump_pressed or Input.is_action_just_pressed("up_jam")) and (is_on_floor() or not _can_double_jump):
		_velocity.y = _jump_moment
		_is_jump = true
		_joystick_jump_pressed = false
		jump_effect.play()
		if not _can_double_jump:
			_can_double_jump = true
		
	if is_on_floor():
		_can_double_jump = false
	
	if raycast.is_colliding() and not _is_killer and not vulnerable:
		_is_killer = true
	
	
func _physics_process(delta):
	_velocity.y += GRAVITY * delta
	get_input()
	_animation()
	_velocity = move_and_slide(_velocity, Vector2.UP)
	

func player_die():
	_is_die = true
	visible = false
	lives -= 1
	$position_virus.player_die()
	emit_signal("die", lives)


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "hurt":
		_is_hurt = false
	elif anim_name == "killer":
		_is_killer = false


func _on_out_vulnerability_timeout():
	vulnerable = true
	aura.visible = false
	aura.playing = false
	


func _on_AudioStreamPlayer2D_finished():
	if not _is_die:
		$sounds/background.play()
