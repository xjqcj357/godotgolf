extends Node2D

var strokes := 0

func _ready():
    _update_ui()

func _update_ui():
    $"UI/VBox/StrokeLabel".text = "Strokes: %d" % strokes

func _on_shot_taken():
    strokes += 1
    _update_ui()

func _on_ball_sunk():
    $"UI/VBox/MessageLabel".text = "Hole complete!"
    var t := Timer.new()
    t.one_shot = true
    t.wait_time = 1.5
    add_child(t)
    t.timeout.connect(_on_end_hole)
    t.start()

func _on_end_hole():
    get_tree().change_scene_to_file("res://scenes/Menu.tscn")
