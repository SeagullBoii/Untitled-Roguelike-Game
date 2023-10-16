extends CharacterBody2D
class_name Enemy

var path: PackedVector2Array
@onready var player: CharacterBody2D = get_tree().current_scene.get_node("Player")
@onready var path_timer = $PathTimer
@onready var nav_agent = $NavigationAgent2D

var movement_dir: Vector2

func _ready():
	$PathTimer.start()
	pass

func _process(delta):
	nav_agent.target_position = player.position

	if nav_agent.is_target_reachable():
		var direction
		
		direction = global_position.direction_to(nav_agent.target_position)
		direction = direction.normalized()
		
		position+=direction
	
	
func _on_path_timer_timeout():
	nav_agent.target_position = player.position
