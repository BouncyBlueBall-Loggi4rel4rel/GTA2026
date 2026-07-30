extends Area2D

@export var food_amount: int = 1
var collected := false

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	if collected:
		return

	# If your player controller is a CharacterBody2D (Godot 4 default):
	if body is CharacterBody2D:
		collected = true
		print("berries calling group ui_food, amount =", food_amount)
		get_tree().call_group("ui_food", "add_food", food_amount)
		queue_free()
