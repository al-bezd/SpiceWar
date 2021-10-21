extends RigidBody2D

var rng = RandomNumberGenerator.new()
var health = 200
var damage 
var speed
var is_dead = false

signal hit
signal die
signal add_point

func _ready():
	rng.randomize()
	speed  = rng.randi_range(1,10)
	damage = rng.randi_range(20,50)
	add_to_group('enemys')
	
func _physics_process(delta):
	position.y+=speed
	
	
func hit(damage):
	if not is_dead:
		modulate = Color.red
		$TimerHit.start()
		health-=damage
		if health<=0:
			death()

func death():
	is_dead  = true
	set_collision_layer_bit(0, false) 
	set_collision_mask_bit(0, false) 
	$AnimatedSprite.play()
	emit_signal("add_point")


func _on_AnimatedSprite_frame_changed():
	if $AnimatedSprite.frame==4:
		$stone.hide()


func _on_AnimatedSprite_animation_finished():
	#emit_signal("die")
	queue_free()


func _on_enemy1_body_entered(body):
	print(body.name)
	


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_TimerHit_timeout():
	modulate = Color.white


func _on_TweenDeath_tween_completed(object, key):
	pass # Replace with function body.
