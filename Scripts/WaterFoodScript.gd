extends CanvasLayer

@onready var info_label: Label = $InfoLabel

@onready var water_plus: Button = $WaterPlus
@onready var water_minus: Button = $WaterMinus
@onready var food_plus: Button = $FoodPlus
@onready var food_minus: Button = $FoodMinus
@onready var heal_minus: Button = $HealMinus
@onready var heal_plus: Button = $HealPlus

var water: int = 0
var food: int = 0
var heal: int = 0

func _ready() -> void:
	water_plus.pressed.connect(_on_water_plus_pressed)
	water_minus.pressed.connect(_on_water_minus_pressed)
	food_plus.pressed.connect(_on_food_plus_pressed)
	food_minus.pressed.connect(_on_food_minus_pressed)
	heal_plus.pressed.connect(_on_heal_plus_pressed)
	heal_minus.pressed.connect(_on_heal_minus_pressed)

	_update_label()

func _update_label() -> void:
	info_label.text = "water: %d\nFood: %d\nHeal: %d" % [water, food, heal]

func _on_water_plus_pressed() -> void:
	water += 1
	_update_label()

func _on_water_minus_pressed() -> void:
	water -= 1
	if water < 0: water = 0
	_update_label()

func _on_food_plus_pressed() -> void:
	food += 1
	_update_label()

func _on_food_minus_pressed() -> void:
	food -= 1
	if food < 0: food = 0
	_update_label()

func _on_heal_plus_pressed() -> void:
	heal += 1
	_update_label()

func _on_heal_minus_pressed() -> void:
	heal -= 1
	if heal < 0: heal = 0
	_update_label()
