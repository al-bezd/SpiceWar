extends KinematicBody2D

const WALK_SPEED = 200

onready var BULLET = preload("res://hero/ammo/ammo.tscn")

var health = 200
var velocity = Vector2()
var hitLabels = []
var is_dead=false

signal hit
signal death

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	#$Timer.start()
	pass # Replace with function body.



func _physics_process(delta):
	if not is_dead:
	#velocity.y += delta * GRAVITY

		if Input.is_action_pressed("ui_left") :
			position.x = clamp(position.x-WALK_SPEED*delta,0,9*32)
			#velocity.x = -WALK_SPEED
		elif Input.is_action_pressed("ui_right"):
			position.x = clamp(position.x+WALK_SPEED*delta,0,9*32)
			#velocity.x =  WALK_SPEED
		else:
			velocity.x = 0
		
		if Input.is_action_pressed("ui_up"):
			position.y = clamp(position.y-WALK_SPEED*delta,0,16*32)
			#velocity.y = -WALK_SPEED
		elif Input.is_action_pressed("ui_down"):
			position.y = clamp(position.y+WALK_SPEED*delta,0,16*32)
			#velocity.y =  WALK_SPEED
		else:
			velocity.y = 0

		#move_and_slide(velocity, Vector2(0, -1),false, 4, PI/4, false)
	

func shot():
	if not is_dead:
		var bullet =  BULLET.instance()
		get_node("..").add_child(bullet)
		bullet.global_position = $gunPosition.global_position
	

func hit(damage):
	if not is_dead:
		modulate = Color.red
		$TimerHit.start()
		health-=damage
		print(health)
		show_hit_label(damage)
		if health<=0:
			is_dead=true
			modulate = Color.white
			$AnimatedSprite.play()
			$red_ship.hide()
			
			

	
func show_hit_label(damage):
	var hitLabel = preload("res://modules/DamageLabel.tscn").instance()
	hitLabel.damage = damage
	hitLabel.rect_position = position+Vector2(-16,-100)
	get_node("..").add_child(hitLabel)
	emit_signal("hit")
	

func _on_Timer_timeout():
	shot()
	$TimerShot.start()


func _on_Area2D_body_entered(body):
	print(body.name)
	if body.is_in_group('enemys'):
		if not body.is_dead:
			hit(body.damage)
		


func _on_TimerHit_timeout():
	modulate = Color.white



func _on_KinematicBody2D_death():
	is_dead=true
	$AnimatedSprite.play()
	$red_ship.hide()
	


func _on_AnimatedSprite_animation_finished():
	emit_signal('death')
	queue_free()
