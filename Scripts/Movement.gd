extends CharacterBody2D

@export var speed: float = 400.0


@onready var sprite_front: Sprite2D = $SpriteFront
@onready var sprite_back: Sprite2D = $SpriteBack
@onready var sprite_side: Sprite2D = $SpriteSide
 

func respawn() :
	self.position =  Vector2(0,0)

func _ready() -> void:
	Gamemanager.player = self

func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("left", "right", "up", "down")
	
	velocity = direction * speed
	move_and_slide()

	_update_sprites(direction)

func _update_sprites(direction: Vector2) -> void:
	var dir := direction
	# Hide all first
	if dir != Vector2.ZERO:
		sprite_front.visible = false
		sprite_back.visible = false
		sprite_side.visible = false

	# Use input when moving; otherwise you can base it on velocity to keep last look
	if dir == Vector2.ZERO:
		dir = velocity / speed if speed != 0.0 else Vector2.ZERO
	if dir == Vector2.ZERO:
		return
	

	# Decide front/back vs side
	# If horizontal magnitude is bigger => side
	if abs(dir.x) > abs(dir.y):
		sprite_side.visible = true
		# flip_h: left uses one orientation, right uses the other
		sprite_side.flip_h = dir.x < 0
	else:
		# Vertical movement: up => front, down => back (adjust if yours is reversed)
		if dir.y < 0:
			sprite_front.visible = true
		else:
			sprite_back.visible = true
