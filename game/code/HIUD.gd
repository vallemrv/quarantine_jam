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



