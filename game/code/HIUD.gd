extends CanvasLayer

onready var bar_health =  $TextureProgress
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func update_health(health):
	if health > 0:
		bar_health.value = health
	else:
		bar_health.value = 0

func update_lifes(lifes):
	if lifes == 2:
		$life3.visible = false
	elif lifes == 1:
		$life2.visible = false
	elif lifes == 0:
		$life1.visible = false

func update_score(score):
	$score_label.text = str(score)
