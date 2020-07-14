extends Control

var count : int = 0

var clickpower : int = 1
var clickpower_price : int = 25

var autoclicks : int = 0
var autoclick_price : int = 50

var ticks : int = 1
var tick_price : int = 100

onready var timer = $Timer

onready var counter_label = $CenterContainer/VBoxContainer/MainCounter/Label
onready var counter_button = $CenterContainer/VBoxContainer/MainCounter/Button

onready var clickpower_container = $CenterContainer/VBoxContainer/HBoxContainer/ClickPower
onready var clickpower_label = $CenterContainer/VBoxContainer/HBoxContainer/ClickPower/Label
onready var clickpower_price_label = $CenterContainer/VBoxContainer/HBoxContainer/ClickPower/Price
onready var clickpower_button = $CenterContainer/VBoxContainer/HBoxContainer/ClickPower/Button

onready var autoclick_container = $CenterContainer/VBoxContainer/HBoxContainer/AutoClick
onready var autoclick_label = $CenterContainer/VBoxContainer/HBoxContainer/AutoClick/Label
onready var autoclick_price_label = $CenterContainer/VBoxContainer/HBoxContainer/AutoClick/Price
onready var autoclick_button = $CenterContainer/VBoxContainer/HBoxContainer/AutoClick/Button

onready var tick_container = $CenterContainer/VBoxContainer/HBoxContainer/Tick
onready var tick_label = $CenterContainer/VBoxContainer/HBoxContainer/Tick/Label
onready var tick_price_label = $CenterContainer/VBoxContainer/HBoxContainer/Tick/Price
onready var tick_button = $CenterContainer/VBoxContainer/HBoxContainer/Tick/Button

func _ready():
	timer.connect("timeout", self, "_on_timer_timeout")
	counter_button.connect("pressed", self, "_on_counter_button_pressed")
	clickpower_button.connect("pressed", self, "_on_clickpower_button_pressed")
	autoclick_button.connect("pressed", self, "_on_autoclick_button_pressed")
	tick_button.connect("pressed", self, "_on_tick_button_pressed")
	
	clickpower_container.visible = false
	autoclick_container.visible = false
	tick_container.visible = false
	
	
func update_counter():
	counter_label.text = String(count) + "\n"
	
func _on_timer_timeout():
	count += autoclicks
	
	if count >= clickpower_price:
		clickpower_container.visible = true
	
	if count >= autoclick_price:
		autoclick_container.visible = true
		
	if count >= tick_price:
		tick_container.visible = true
		
	update_counter()
	
func _on_counter_button_pressed():
	count += clickpower
	update_counter()
	
func _on_clickpower_button_pressed():
	if count >= clickpower_price:
		count -= clickpower_price
		update_counter()
		clickpower += 1
		clickpower_label.text = "Click power: " + String(clickpower)
		clickpower_price *= 1.5
		clickpower_price_label.text = "Price: " + String(clickpower_price)

func _on_autoclick_button_pressed():
	if count >= autoclick_price:
		count -= autoclick_price
		update_counter()
		autoclicks += 1
		autoclick_label.text = "AutoClicks: " + String(autoclicks)
		autoclick_price *= 1.5
		autoclick_price_label.text = "Price: " + String(autoclick_price)
		
func _on_tick_button_pressed():
	if count >= tick_price:
		count -= tick_price
		update_counter()
		ticks += 1
		tick_label.text = "Ticks: " + String(ticks)
		tick_price *= 2
		tick_price_label.text = "Price: " + String(tick_price)
		timer.wait_time *= 0.5
