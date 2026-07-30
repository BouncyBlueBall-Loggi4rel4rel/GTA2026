extends CanvasLayer

@onready var info_label: Label = $InfoLabel

@onready var water_plus: Button = $WaterPlus
@onready var water_minus: Button = $WaterMinus
@onready var heal_minus: Button = $HealMinus
@onready var heal_plus: Button = $HealPlus

@onready var hunger_bar: TextureProgressBar = $ProgressBarHunger
@onready var eat_button: Button = $Eat # <-- change if your eat button is named Button2/Button3

var water: int = 0
var food: int = 0
var heal: int = 0

var hunger_add_percent := 10.0
var food_cost := 1

func add_food(amount: int) -> void:
	food += amount
	_update_label()

func _ready() -> void:
	water_plus.pressed.connect(_on_water_plus_pressed)
	water_minus.pressed.connect(_on_water_minus_pressed)
	heal_plus.pressed.connect(_on_heal_plus_pressed)
	heal_minus.pressed.connect(_on_heal_minus_pressed)

	eat_button.pressed.connect(_on_eat_button_pressed)

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

func _on_heal_plus_pressed() -> void:
	heal += 1
	_update_label()

func _on_heal_minus_pressed() -> void:
	heal -= 1
	if heal < 0: heal = 0
	_update_label()

func _on_eat_button_pressed() -> void:
	if food < food_cost:
		return

	food -= food_cost
	_update_label()

	var current := float(hunger_bar.value)
	var add_amount := hunger_bar.max_value * (hunger_add_percent / 100.0)
	hunger_bar.set_progress(current + add_amount)
