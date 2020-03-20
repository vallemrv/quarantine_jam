extends Node2D

onready var HIUD = $HIUD
onready var Player = $Player
onready var time_respaw = $timers/time_respaw
onready var count_asset = $timers/count_asset
onready var joystick = $HIUD/base_joystick/joystick
onready var ration_movement = $timers/ration_movement

var _can_refresh = true

# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.level == 1:
		Global.lives = Player.LIVES
		Global.score = 0
		Global.health = Player.HEALTH
	else:
		Player.lives = Global.lives
		Player.health = Global.health
		Player.score = Global.score
		
	HIUD.update_health(Global.health)
	HIUD.update_lifes(Global.lives)
	HIUD.update_score(Global.score)
	HIUD.update_level(Global.level)
	HIUD.update_info_roll($Asset.get_child_count())

func _on_bound_body_entered(body):
	if body.name == "Player":
		body.player_die()

func _on_Player_die(life):
	if life > -1:
		HIUD.update_lifes(life)
		time_respaw.start()
		$transition.interpolate_property(self, "modulate", Color(1, 1, 1, 1), Color(1, 1, 1, 0), 0.35,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$transition.start()
		$transition.interpolate_property(self, "modulate", Color(1, 1, 1, 0), Color(1, 1, 1, 1), 0.35,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$transition.start()
	else:
		game_over()


func _process(delta):
	var value_joystick = joystick.get_value()*delta
	if _can_refresh or value_joystick == Vector2.ZERO:
		_can_refresh = value_joystick == Vector2.ZERO
		ration_movement.start()
		Player.set_value_joystick(value_joystick)
	
func _on_Player_take_damage(health):
	HIUD.update_health(health)


func game_over():
	$transition.interpolate_property(self, "modulate", Color(1, 1, 1, 1), Color(1, 1, 1, 0), 0.35,
	Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$transition.start()
	yield(get_tree().create_timer(.5), "timeout")
	if get_tree().change_scene("res://scenes/1_game_over.tscn") != OK:
		print_debug("An error occured when trying to reload the current scene at Level.gd.")


func _on_time_respaw_timeout():
	Player.global_position = $respaw.global_position
	Player.respaw()
	HIUD.update_health(Player.HEALTH)


func _on_Player_take_score(score):
	HIUD.update_score(score)


func _on_Player_take_roll(score):
	HIUD.update_score(score)
	count_asset.start()


func _on_count_asset_timeout():
	var asset = $Asset.get_child_count()
	if asset > 0:
		HIUD.update_info_roll(asset)
	else:
		Global.lives = Player.lives
		Global.score = Player.score
		Global.health = Player.health
		Global.level += 1
		$transition.interpolate_property(self, "modulate", Color(1, 1, 1, 1), Color(1, 1, 1, 0), 0.35,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$transition.start()
		yield(get_tree().create_timer(.5), "timeout")
		if get_tree().change_scene(Global.get_next_level()) != OK:
			print_debug("An error occured when trying to reload the current scene at Level.gd.")


func _on_ration_movement_timeout():
	_can_refresh = true

func _on_base_joystick_pressed():
	Player.jump()
