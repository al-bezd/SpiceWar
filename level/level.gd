extends Node2D
var rnd  = RandomNumberGenerator.new()
var asteroid =0

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	
	rnd.randomize()
	$Camera2D.limit_left = 0
	$Camera2D.limit_bottom = 16*32
	$Camera2D.limit_right = 9*32
	respawn_asteroid()
	$TimerRespEnemy.start()
	var n = $Camera2D/ParallaxBackground/ParallaxLayer/space.get_rect()
	$Camera2D/ParallaxBackground/ParallaxLayer.motion_mirroring = Vector2(0,n.size.y)
	$Camera2D/HBoxContainer/Asteroids.text = "x %s"%asteroid
	$ship.connect("hit",self,'hit_to_hero')
	$ship.connect("death",self,'game_over')


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _process(delta):
	$Camera2D/ParallaxBackground.scroll_offset.y-=20*delta
	if $ship!=null:
		$Camera2D/Label.text = str($ship.health)
	else:
		$Camera2D/Label.text = ''
	$Camera2D/HBoxContainer/Asteroids.text = "x %s"%asteroid
	print(str(asteroid))
	
	
func respawn_asteroid():
	for i in 5:
		var asteroid  = preload("res://enemy/enemy1.tscn").instance()
		asteroid.connect("add_point",self,'add_point')
		add_child(asteroid)
		#asteroid.connect("is_dead",self,'respawn_asteroid')
		asteroid.position = Vector2(rnd.randi_range(32,9*32),-1000)
	


func _on_TimerRespEnemy_timeout():
	respawn_asteroid()
	
func add_point():
	asteroid+=1
	$Camera2D/HBoxContainer/TweenAsteroids.interpolate_property(
		$Camera2D/HBoxContainer/Asteroids,
		'rect_scale',
		Vector2($Camera2D/HBoxContainer/Asteroids.rect_scale.x*2,$Camera2D/HBoxContainer/Asteroids.rect_scale.x*2),
		$Camera2D/HBoxContainer/Asteroids.rect_scale,
		0.2,Tween.TRANS_BOUNCE,Tween.EASE_IN_OUT)
	$Camera2D/HBoxContainer/TweenAsteroids.start()


func _on_TweenAsteroids_tween_completed(object, key):
	$Camera2D/HBoxContainer/Asteroids.rect_scale=Vector2(1,1)

func hit_to_hero():
	$Camera2D/Label.modulate = Color.red
	#$Camera2D/Label.add_color_override("font_color", Color.red)
	#$Camera2D/Label.set("custom_colors/font_color", Color.red)

	$Camera2D/TweenHitOnHero.interpolate_property(
		$Camera2D/Label,
		'rect_scale',
		Vector2($Camera2D/Label.rect_scale.x*2,$Camera2D/Label.rect_scale.x*2),
		$Camera2D/Label.rect_scale,
		0.2,Tween.TRANS_BOUNCE,Tween.EASE_IN_OUT)
	$Camera2D/TweenHitOnHero.start()
	


func _on_TweenHitOnHero_tween_completed(object, key):
	$Camera2D/Label.rect_scale=Vector2(1,1)
	$Camera2D/Label.modulate = Color.white
	#$Camera2D/Label.add_color_override("font_color", Color.white)
	#$Camera2D/Label.set("custom_colors/font_color", Color.white)

func game_over():
	
	$Camera2D/GameOverMenu.text = 'START'
	$TweenGameOverMenuStart.interpolate_property($Camera2D/GameOverMenu,'rest_position',
	Vector2(-100,-32*8),Vector2(32*4,-32*8),1,Tween.TRANS_ELASTIC,Tween.EASE_IN_OUT)
	$TweenGameOverMenuStart.start()
	#queue_free()
	#get_tree().change_scene("res://level/level.tscn")
