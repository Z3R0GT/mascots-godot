@tool
extends AnimatedSprite2D
class_name Mascot

@export var idle: SpriteFrames:
	set(value):
		if value == null:
			return
		idle = value
		GodotMascotHelper.add_textures(sprite_frames, idle, "idle")
@export var walk: SpriteFrames:
	set(value):
		if value == null:
			return
		walk = value
		GodotMascotHelper.add_textures(sprite_frames, walk, "walk")

func _init() -> void:
	sprite_frames = SpriteFrames.new()

var randomness: int
func _ready() -> void:
	randomness = randi_range(5, 20)
	var time = Timer.new()
	time.connect("timeout", move)
	add_child(time)
	time.start(randomness)

var is_moving: bool = false
var position_objective: int
func move() -> void:
	if is_moving:
		return
	is_moving = true
	position_objective = randi_range(0, get_parent().size.x)

func _physics_process(delta: float) -> void:
	if position.x == 0 or position.x >= get_parent().size.x:
		position.x = 20
		is_moving = false
		move()
		return
	
	if is_moving:
		if animation != "walk":
			stop()
			play("walk")
		
		if position_objective == position.x:
			is_moving = false
		
		if position_objective > position.x:
			flip_h = false
			position.x += 1
		else:
			flip_h = true
			position.x -= 1
	else:
		if animation != "idle":
			stop()
			play("idle")
	
