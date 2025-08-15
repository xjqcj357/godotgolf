extends Area2D
signal ball_sunk

func _on_body_entered(body):
    if body is RigidBody2D and body.name == "Ball":
        emit_signal("ball_sunk")
