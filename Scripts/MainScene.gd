extends Node3D

@onready var world_environment: WorldEnvironment = %WorldEnvironment
@onready var water_mesh: MeshInstance3D = %WaterMesh
@onready var water_material: StandardMaterial3D = water_mesh.mesh.material
@onready var fps: Label = %FPS
@onready var timer: Timer = %Timer

func _ready() -> void:
	_on_timer_timeout()
	timer.start()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()
	elif Input.is_action_just_pressed("quit"):
		get_tree().quit()

func _physics_process(delta: float) -> void:
	var speed: float = 0.01 * delta
	world_environment.environment.sky_rotation.y -= speed
	water_material.uv1_offset.x -= speed

func _on_timer_timeout() -> void:
	fps.text = "FPS: %.0f" % Engine.get_frames_per_second()
