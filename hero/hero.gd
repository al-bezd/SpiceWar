extends KinematicBody2D

const WALK_SPEED = 200

onready var BULLET = preload("res://hero/ammo/ammo.tscn")

var health = 1000
var velocity = Vector2()

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	#$Timer.start()
	pass # Replace with function body.



func _physics_process(delta):
	#velocity.y += delta * GRAVITY

	if Input.is_action_pressed("ui_left"):
		velocity.x = -WALK_SPEED
	elif Input.is_action_pressed("ui_right"):
		velocity.x =  WALK_SPEED
	else:
		velocity.x = 0
	
	if Input.is_action_pressed("ui_up"):
		velocity.y = -WALK_SPEED
	elif Input.is_action_pressed("ui_down"):
		velocity.y =  WALK_SPEED
	else:
		velocity.y = 0
		
	

	# We don't need to multiply velocity by delta because "move_and_slide" already takes delta time into account.

	# The second parameter of "move_and_slide" is the normal pointing up.
	# In the case of a 2D platformer, in Godot, upward is negative y, which translates to -1 as a normal.
	move_and_slide(velocity, Vector2(0, -1),false, 4, PI/4, false)

func shot():
	var bullet =  BULLET.instance()
	get_node("..").add_child(bullet)
	bullet.global_position = $Position2D.global_position
	

func hint(damage):
	modulate = Color.red
	$TimerHit.start()
	health-=damage
	print(health)


func _on_Timer_timeout():
	shot()
	$TimerShot.start()


func _on_Area2D_body_entered(body):
	print(body.name)
	if body.is_in_group('enemys'):
		hint(body.damage)
		


func _on_TimerHit_timeout():
	modulate = Color.white
