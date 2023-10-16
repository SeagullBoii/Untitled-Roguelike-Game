extends CharacterBody2D
class_name Character

const FRICTION: float = 0.15

@export var acceleration = 40
@export var max_speed = 100

var movement_dir = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	move_and_slide()
	velocity = lerp(velocity, Vector2.ZERO, FRICTION)

func move() -> void:
	movement_dir = movement_dir.normalized()
	velocity += movement_dir+acceleration
	velocity = velocity.limit_length(max_speed)
