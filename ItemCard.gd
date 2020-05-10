extends VBoxContainer

var item = {}

signal item_bought(item)
signal item_saved(item)

func connect_buy_button(store):
	self.connect("item_bought", store, "_on_item_bought")
	self.connect("item_saved", store, "_on_item_saved")

func set_data(i):
	item = i
	
	$TitleLabel.text = item.title
	$TypeLabel.text = item.type
	$PriceLabel.text = "$" + str(item.price)

func _on_BuyButton_pressed():
	emit_signal("item_bought", item)


func _on_SaveButton_pressed():
	emit_signal("item_saved", item)
