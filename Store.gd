extends Control

signal start_next_day(budget)

var rng = RandomNumberGenerator.new()
var item_card_scene = preload("res://ItemCard.tscn")

var items = []
var budget = 0

var MAX_ITEMS = 6

func set_budget(b):
	budget = b
	
func reset():
	self.queue_free()

func _select_items(num_to_select):
	var all_items = constants.get_items()
	var selected_item_ids = []
	for saved_item in GameVariables.saved_items:
		selected_item_ids.append(saved_item.id)
	var owned_item_ids = GameVariables.owned_item_ids
	while selected_item_ids.size() < num_to_select:
		var item_index = rng.randi_range(0, all_items.size()-1)
		var item_id = all_items[item_index].id
		while selected_item_ids.has(item_id) || owned_item_ids.has(item_id):
			item_index = rng.randi_range(0, all_items.size()-1)
			item_id = all_items[item_index].id
		selected_item_ids.append(item_id)
	for item in all_items:
		if selected_item_ids.has(item.id):
			items.append(item)

func _add_item_cards():
	for item in items:
		var item_card = item_card_scene.instance()
		item_card.set_data(item)
		item_card.connect_buy_button(self)
		add_child(item_card)
		
func _on_item_bought(item):
	if item.price <= budget:
		GameVariables.unassigned_items.append(item)
		GameVariables.owned_item_ids.append(item.id)
		budget -= item.price
	
	
func _on_item_saved(item):
	GameVariables.saved_items.append(item)
	
func _ready():
	self.connect("start_next_day", get_node("/root/Main"), "_on_close_Store")
	rng.randomize()
	items = GameVariables.saved_items
	GameVariables.saved_items = []
	self._select_items(MAX_ITEMS - items.size())
	self._add_item_cards()

func _on_Done_pressed():
	emit_signal("start_next_day", budget)
