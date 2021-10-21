extends Label

class_name DamageLabel

export var damage=0

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	text = str(damage)

func _physics_process(delta):
	rect_scale+=Vector2(0.5*delta,0.5*delta)


func _on_Timer_timeout():
	
	$Tween.interpolate_property(self, "rect_position",
		rect_position, rect_position+Vector2(1000, -500), 0.5,
		Tween.TRANS_BOUNCE, Tween.EASE_IN_OUT)
	$Tween.start()
	


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


