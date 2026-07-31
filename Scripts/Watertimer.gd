extends Timer

@export var target_path: NodePath

func _ready() -> void:
	if target_path == NodePath():
		push_error("Set target_path to your node that has hurt().")
		return

	timeout.connect(_on_timeout)

func _on_timeout() -> void:
	var target := get_node_or_null(target_path)
	if target and target.has_method("hurt"):
		target.hurt()
