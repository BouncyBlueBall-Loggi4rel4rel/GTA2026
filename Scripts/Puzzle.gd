extends Area2D

@export var manager_path: NodePath
@onready var manager: Node = get_node(manager_path)

func _ready() -> void:
	# Ensure collisions etc. are set up (collision layer/mask, monitoring, etc.)
	pass

func _on_body_entered(body: Node) -> void:
	print("collect")
	if body.is_in_group("player"):
		print("Yay")
		manager.register_collectible_collected()
		queue_free()
