extends Control

var rng = RandomNumberGenerator.new()
var item_card_scene = preload("res://ItemCard.tscn")

var items = []
var budget = 0

var MAX_ITEMS = 6

func set_budget(b):
	budget = b

func _select_items(num_to_select):
	var all_items = constants.get_items()
	var selected_item_indexes = []
	while selected_item_indexes.size() < num_to_select:
		print(all_items.size())
		var item_index = rng.randi_range(0, all_items.size()-1)
		while selected_item_indexes.has(item_index):
			item_index = rng.randi_range(0, all_items.size()-1)
		selected_item_indexes.append(item_index)
	for index in selected_item_indexes:
		print(index)
		items.append(all_items[index])

func _add_item_cards():
	for item in items:
		var item_card = item_card_scene.instance()
		item_card.set_data(item)
		item_card.connect_buy_button(self)
		add_child(item_card)
		
func _on_item_bought(item):
	print(item)
	
func _on_item_saved(item):
	GameVariables.saved_items.append(item)
	
func _ready():
	rng.randomize()
	items = GameVariables.saved_items
	GameVariables.saved_items = []
	self._select_items(MAX_ITEMS - items.size())
	self._add_item_cards()

func _on_Done_pressed():
	pass
