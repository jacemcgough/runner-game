extends ParallaxBackground

@export var speed = 0

func _process(delta):
    var new_offset = get_scroll_offset() + Vector2(-speed, 0) * delta
    set_scroll_offset(new_offset)
