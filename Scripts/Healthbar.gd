extends TextureProgressBar

func set_progress(p: float) -> void:
	value = clamp(p, min_value, max_value)

func hurt() -> void:
	if value <= min_value:
		return
	value = clamp(value - (max_value * 0.2), min_value, max_value)

func _ready() -> void:
	print("Healthbar ready, max=", max_value)
	set_progress(100)
