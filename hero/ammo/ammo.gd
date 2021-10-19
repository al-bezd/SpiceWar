extends Area2D
var damage = [20,50]
var rng = RandomNumberGenerator.new()
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	position.y -= 10
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	
	if body.is_in_group('enemys'):
		rng.randomize()
		body.hit(rng.randf_range(damage[0],damage[1]))

	#pass # Replace with function body.


func _on_Timer_timeout():
	death() # Replace with function body.

func death():
	queue_free()
