extends CharacterBody3D

@export var speed: float = 200.0

@onready var left_score: Label = %LeftScore
@onready var right_score: Label = %RightScore

var direction: Vector3 = Vector3.ZERO

func _ready() -> void:
	position.x = 0.0
	position.y = 0.0

	var direction_2d: Vector2 = Vector2(randf(), randf())
	while absf(absf(direction_2d.x) - absf(direction_2d.y)) > 0.25:
		direction_2d = Vector2(randf(), randf())
	direction_2d = ((direction_2d * 2.0) - Vector2.ONE).normalized()
	direction = Vector3(direction_2d.x, direction_2d.y, 0.0)

func _physics_process(delta: float) -> void:
	velocity = direction * speed * delta
	move_and_slide()

	var collision: KinematicCollision3D = get_slide_collision(0)
	if collision:
		var collider: Object = collision.get_collider()
		if collider.bounce:
			if collider.is_platform:
				direction.x = -direction.x
				direction.y += collision.get_position().y - collider.global_position.y
				if absf(absf(direction.x) - absf(direction.y)) > 0.25:
					direction.x += 0.1
				direction = direction.normalized()
			else:
				direction.y = -direction.y
		else:
			if position.x > 0.0:
				var score: int = int(left_score.text) + 1
				left_score.text = str(score)
			else:
				var score: int = int(right_score.text) + 1
				right_score.text = str(score)
			_ready()
