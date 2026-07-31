extends CanvasLayer

@onready var info_label: Label = $InfoLabel

@onready var heal_minus: Button = $HealMinus
@onready var heal_plus: Button = $HealPlus

@onready var hunger_bar: TextureProgressBar = $ProgressBarHunger
@onready var water_bar: TextureProgressBar = $ProgressBarWater
@onready var health_bar: TextureProgressBar = $ProgressBarHealth

@onready var eat_button: Button = $Eat
@onready var drink_button: Button = $Drink

var water: int = 0
var food: int = 0
var heal: int = 0

var hunger_add_percent := 10.0
var water_add_percent := 3.0

var food_cost := 1
var water_cost := 1

func respawn() :
	water = 0
	food = 0
	heal = 0
	_update_label()
	hunger_bar.set_progress(100)
	water_bar.set_progress(100)
	health_bar.set_progress(100)
	Gamemanager.player.respawn()

func add_food(amount: int) -> void:
	food += amount
	_update_label()

func set_water_to(amount: int) -> void:
	water = amount
	_update_label()



func _ready() -> void:
	heal_plus.pressed.connect(_on_heal_plus_pressed)
	heal_minus.pressed.connect(_on_heal_minus_pressed)
	eat_button.pressed.connect(_on_eat_button_pressed)
	drink_button.pressed.connect(_on_drink_button_pressed)

	_update_label()

func _update_label() -> void:
	info_label.text = "water: %d\nFood: %d\nHeal: %d" % [water, food, heal]

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

func _on_drink_button_pressed() -> void:
	if water < water_cost:
		return

	water -= water_cost
	_update_label()

	var current := float(water_bar.value)
	var add_amount := water_bar.max_value * (water_add_percent / 100.0)
	water_bar.set_progress(current + add_amount)
