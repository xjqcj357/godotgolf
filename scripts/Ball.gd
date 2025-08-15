extends RigidBody2D
signal shot_taken

@export var power_scale: float = 10.0
@export var max_impulse: float = 1500.0
@export var aim_slop: float = 20.0
@export var stop_threshold: float = 5.0

var dragging := false

func _ready():
    gravity_scale = 0

func _unhandled_input(event):
    if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
        if event.pressed:
            if linear_velocity.length() <= stop_threshold and (global_position - event.position).length() <= ($CollisionShape2D.shape.radius + aim_slop):
                dragging = true
                $Line2D.visible = true
                _update_line(event.position)
        else:
            if dragging:
                var drag_vec: Vector2 = event.position - global_position
                var impulse: Vector2 = -drag_vec * power_scale
                if impulse.length() > max_impulse:
                    impulse = impulse.normalized() * max_impulse
                apply_impulse(impulse)
                dragging = false
                $Line2D.visible = false
                emit_signal("shot_taken")
    elif event is InputEventMouseMotion and dragging:
        _update_line(event.position)

func _update_line(mouse_pos: Vector2) -> void:
    var local := to_local(mouse_pos)
    $Line2D.clear_points()
    $Line2D.add_point(Vector2.ZERO)
    $Line2D.add_point(local)
