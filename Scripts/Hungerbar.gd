extends TextureProgressBar

func set_progress(p: float) -> void:
	value = clamp(p, min_value, max_value)

func hurt() -> void:
	if value == 0:
		return
	value = clamp(value - (max_value * 0.02), min_value, max_value)

func _ready() -> void:
	set_progress(100)
