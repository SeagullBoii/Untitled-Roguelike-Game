extends CharacterBody2D

@onready var anim_tree = $Sprite/AnimTree
@onready var weaponSprite = $Weapons/WeaponPivot/Sprite2D

var currentWeapon = "Axe"
var weaponDictionary = {
	"Axe": {
		"SpriteOffset": Vector2(5, -2),
		"FlippedSpriteOffset": Vector2(-5,-2),
		"Damage": 5 ,
		"Location": 1,
		"AnimationRight": "MediumSlashRight",
		"AnimationLeft": "MediumSlashLeft"
	}
}

var movement_vector = Vector2.ZERO
var moving = false

@export var sprintSpeed = 0;
@export var walkSpeed = 0;
var speed = 0;

func _ready():
	anim_tree.active = true

func _process(delta):
	rotate_weapon()
	sprint()
	rotate_player()
	move_player()
	play_anims()
	swing_weapon(delta)

func swing_weapon(delta):

	if Input.is_action_just_pressed("Attack"):
		if position.x - get_global_mouse_position().x < 0:
			$Sprite/AnimTree/AnimationPlayer.play(weaponDictionary[currentWeapon]["AnimationRight"])
		else:
			$Sprite/AnimTree/AnimationPlayer.play(weaponDictionary[currentWeapon]["AnimationLeft"])
	
func rotate_weapon():
	var mousePos = get_global_mouse_position()

	$Weapons/WeaponPivot/Sprite2D.rotation = get_angle_to(get_global_mouse_position())
		
	if position.x - mousePos.x > 0:
		$Weapons/WeaponPivot/Sprite2D.flip_v = true
	else:
		$Weapons/WeaponPivot/Sprite2D.flip_v = false
		
func rotate_player():
	var mousePos = get_global_mouse_position()
	if (mousePos.x < position.x):
		$Sprite.flip_h = true
	else:
		$Sprite.flip_h = false
	
func move_player():
	if abs(movement_vector.y) > 0:
		movement_vector.y -= movement_vector.y/abs(movement_vector.y)
	if abs(movement_vector.x) > 0:
		movement_vector.x -= movement_vector.x / abs(movement_vector.x)
		
	if abs(movement_vector.y) < 1:
		if (Input.is_action_pressed("MoveUp")):
			movement_vector.y = -1

		elif (Input.is_action_pressed("MoveDown")):
			movement_vector.y = 1

		
	if abs(movement_vector.x) < 1:
		if (Input.is_action_pressed("MoveLeft")):
			movement_vector.x = -1

		elif (Input.is_action_pressed("MoveRight")):
			movement_vector.x = 1

			
	position += movement_vector.normalized() * speed
		
	moving = movement_vector != Vector2.ZERO

func sprint():
	if !Input.is_action_pressed("Sprint"):
		if (speed < sprintSpeed):
			speed += 0.2
		else: 
			speed = sprintSpeed
	
	else:
		if (speed > walkSpeed):
			speed -= 0.2
		else: 
			speed = walkSpeed
	
func play_anims():
	if moving:
		anim_tree["parameters/conditions/is_moving"] = true
		anim_tree["parameters/conditions/is_idle"] = false
	else:
		anim_tree["parameters/conditions/is_moving"] = false
		anim_tree["parameters/conditions/is_idle"] = true


func _on_slash_timer_timeout():
	anim_tree[weaponDictionary[currentWeapon]["AnimationCondition"]] = false
	print(anim_tree[weaponDictionary[currentWeapon]["AnimationCondition"]])
