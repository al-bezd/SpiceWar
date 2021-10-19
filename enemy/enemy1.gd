extends RigidBody2D

var rng = RandomNumberGenerator.new()
var health = 200
var damage 
var speed

signal hit
signal is_dead

func _ready():
	rng.randomize()
	speed  = rng.randi_range(1,10)
	damage = rng.randi_range(20,50)
	add_to_group('enemys')
	
func _physics_process(delta):
	position.y+=speed
	
	
func hit(damage):
	modulate = Color.red
	$TimerHit.start()
	health-=damage
	if health<=0:
		death()

func death():
	
	#$CollisionShape2D/AnimatedSprite.show()
	sleeping=true
	$AnimatedSprite.play()
	
	#queue_free()





func _on_AnimatedSprite_frame_changed():
	if $AnimatedSprite.frame==4:
		$stone.hide()


func _on_AnimatedSprite_animation_finished():
	queue_free()


func _on_enemy1_body_entered(body):
	print(body.name)
	


func _on_VisibilityNotifier2D_screen_exited():
	death()
	emit_signal("is_dead")


func _on_TimerHit_timeout():
	modulate = Color.white
