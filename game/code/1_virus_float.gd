extends RigidBody2D


export var SPEED_MAX = 150
export var SPEED_MIN = 100
export var DAMAGE = 10

var Virus

var _velocity = Vector2.ZERO
var _dir = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	Virus = load( "res://scenes/1_virus_b.tscn")

func _on_Area2D_body_entered(body):
	if body.name == "World":
		var v = Virus.instance()
		v.global_position = global_position - Vector2(0,50)
		get_tree().root.call_deferred("add_child", v)
		queue_free()
	if body.name == "Player":
		if body.vulnerable:
			body.take_damage(DAMAGE)
			$Area2D/CollisionShape2D.call_deferred("disabled", true)
			gravity_scale = 0
			$AnimationPlayer.play("attack")


func _on_VisibilityNotifier2D_screen_exited():
	pass#queue_free()
	

func _on_time_life_timeout():
	queue_free()
