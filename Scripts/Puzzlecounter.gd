extends Node

@onready var label: Label = $Collected # <-- must exist as a child of Puzzle/Collected

@export var total_collectibles: int = 4
var collected_count: int = 0

func _ready() -> void:
	update_label()

func register_collectible_collected() -> void:
	collected_count += 1
	collected_count = min(collected_count, total_collectibles)
	update_label()
	if collected_count == 4:
		$"Totally portal".visible = true
		$PortalOpened.show()

func update_label() -> void:
	label.text = "%d/%d" % [collected_count, total_collectibles]
