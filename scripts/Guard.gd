extends CharacterBody2D

@export var patrol_points: Array[Vector2] = []
@export var speed: float = 100.0

var _current_index: int = 0
@onready var light: Light2D = $Light2D

func _ready() -> void:
    _setup_flashlight()

func _physics_process(delta: float) -> void:
    if patrol_points.is_empty():
        velocity = Vector2.ZERO
        return

    var target: Vector2 = patrol_points[_current_index]
    var to_target: Vector2 = target - global_position
    if to_target.length() < 5.0:
        _current_index = (_current_index + 1) % patrol_points.size()
        target = patrol_points[_current_index]
        to_target = target - global_position
    velocity = to_target.normalized() * speed
    if velocity.length() > 0:
        rotation = velocity.angle()
    move_and_slide()

func _setup_flashlight() -> void:
    var grad := Gradient.new()
    grad.colors = PackedColorArray([Color(1, 1, 0, 1), Color(1, 1, 0, 0)])
    var tex := GradientTexture2D.new()
    tex.gradient = grad
    tex.width = 256
    tex.height = 256
    tex.fill = GradientTexture2D.FILL_RADIAL
    light.texture = tex
    var mat := ShaderMaterial.new()
    mat.shader = load("res://assets/flashlight_cone.gdshader")
    light.material = mat
