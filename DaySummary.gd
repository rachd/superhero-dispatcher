extends PanelContainer

signal reset(budget)

var starting_budget = 0
var amount_spent = 0
var income = 2000
var is_loss = false
const constants = preload("constants.gd")

func set_values(old_budget, new_budget):
	starting_budget = old_budget
	amount_spent = old_budget - new_budget
	if new_budget < 0:
		is_loss = true
		
func reset():
	self.queue_free()

func _ready():
	self.connect("reset", get_node("/root/Main"), "_on_Reset")
	$VBoxContainer/BudgetLabel.text = "$" + str(starting_budget)
	$VBoxContainer/AmountSpentLabel.text = "$" + str(amount_spent)
	$VBoxContainer/TotalLabel.text = "$" + str(starting_budget - amount_spent)
	if is_loss:
		$VBoxContainer/LossLabel.text = "You Lose"
		$VBoxContainer/Button.text = "Play Again"
	else:
		$VBoxContainer/LossLabel.text = ""
		$VBoxContainer/Button.text = "Continue"

func _on_Button_pressed():
	if is_loss:
		emit_signal("reset", constants.get_initial_budget())
	else:
		emit_signal("reset", starting_budget - amount_spent + income)
