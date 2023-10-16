extends CharacterBody3D

@export var is_player: bool = false
@export var player_speed: float = 0.25
@export var ball: CharacterBody3D
@export var pc_lerp_speed: float = 2.0

const bounce: bool = true
const is_platform: bool = true

var motion: float = 0.0

func _ready() -> void:
	if is_player:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event: InputEvent) -> void:
	if is_player and event is InputEventMouseMotion:
		motion = -event.relative.y

func _physics_process(delta: float) -> void:
	if is_player:
		if motion == 0.0:
			motion = -Input.get_axis("up", "down") * 20.0

		if motion != 0.0:
			position.y += motion * player_speed * delta
			position.y = clampf(position.y, -2.0, 2.0)
			motion = 0.0
	else:
		position.y = lerpf(position.y, ball.position.y, pc_lerp_speed * delta)
		position.y = clampf(position.y, -2.0, 2.0)
