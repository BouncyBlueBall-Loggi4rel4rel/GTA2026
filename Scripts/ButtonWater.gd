extends Button

@export var target_path: NodePath

func _ready() -> void:
	if target_path == NodePath():
		push_error("Set target_path to your TextureProgressBar node.")
		return

func _pressed() -> void:
	var target := get_node_or_null(target_path)
	if target and target.has_method("hurt"):
		target.hurt()
