extends Node2D

export var damage = 100
export var max_health = 100

var current_health = max_health

signal do_damage(damage)
signal villain_selected(villain)

func do_damage():
	var position = self.position
	var tilemap = get_node("/root/Main/TownTileMap")
	var cell_coord = tilemap.world_to_map(position)
	var cell_type_id = tilemap.get_cellv(cell_coord)
	emit_signal("do_damage", damage, cell_type_id)

func take_damage(damage):
	current_health -= damage
	$Label.text = current_health
		
func _on_DamageTimer_timeout():
	do_damage()

func pause(isPaused):
	$DamageTimer.set_paused(isPaused)
	
func on_click():
	emit_signal("villain_selected", self)

func spawn():
	self.connect("do_damage", get_node("/root/Main"), "_on_Villain_do_damage")
	self.connect("villain_selected", get_node("/root/Main"), "_on_Villain_clicked")
	$DamageTimer.start()
