extends Node2D
var rnd  = RandomNumberGenerator.new()


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	rnd.randomize()
	$StaticBody2D/Camera2D.limit_left = 0
	$StaticBody2D/Camera2D.limit_bottom = 16*32
	$StaticBody2D/Camera2D.limit_right = 9*32
	$TimerRespEnemy.start()



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _process(delta):
	$StaticBody2D.position.y-=0.1
	$StaticBody2D/Label.text = str($ship.health)
	
	
func respawn_asteroid():
	for i in 5:
		var asteroid  = preload("res://enemy/enemy1.tscn").instance()
		add_child(asteroid)
		#asteroid.connect("is_dead",self,'respawn_asteroid')
		asteroid.position = Vector2(rnd.randi_range(32,9*32),-1000)
	


func _on_TimerRespEnemy_timeout():
	respawn_asteroid()
