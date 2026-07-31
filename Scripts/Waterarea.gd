extends Area2D

@export var water_amount_to_set := 10

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	if not body.is_in_group("player"):
		return

	get_tree().call_group("ui_food", "set_water_to", water_amount_to_set)
