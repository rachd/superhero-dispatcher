extends PanelContainer

signal reset(budget)

var budget = 0
var amount_spent = 0
var is_loss = false
const constants = preload("constants.gd")

func set_values(new_budget, new_spent):
	budget = new_budget
	amount_spent = new_spent
	if budget - amount_spent < 0:
		is_loss = true

func _ready():
	$VBoxContainer/BudgetLabel.text = "$" + str(budget)
	$VBoxContainer/AmountSpentLabel.text = "$" + str(amount_spent)
	$VBoxContainer/TotalLabel.text = "$" + str(budget - amount_spent)
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
		emit_signal("reset", constants.get_initial_budget() + (budget - amount_spent))
