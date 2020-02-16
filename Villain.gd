extends Node2D

export var damage = 10
export var max_health = 100

var current_health = max_health
var engaged_hero = null

signal do_damage(damage)
signal villain_selected(villain)
signal villain_dead(villain)

func do_damage():
	if (engaged_hero):
		engaged_hero.take_damage(damage)
	else:
		var position = self.position
		var tilemap = get_node("/root/Main/TownTileMap")
		var cell_coord = tilemap.world_to_map(position)
		var cell_type_id = tilemap.get_cellv(cell_coord)
		emit_signal("do_damage", damage, cell_type_id)

func take_damage(damage):
	current_health -= damage
	$Label.text = str(current_health)
	if (current_health <= 0):
		die()
				
func die():
	emit_signal("villain_dead", self, engaged_hero)
	$DamageTimer.stop()
	
func _on_DamageTimer_timeout():
	do_damage()

func pause(isPaused):
	$DamageTimer.set_paused(isPaused)
	
func on_click():
	emit_signal("villain_selected", self)
	
func start_attack(hero):
	engaged_hero = hero
	
func stop_attack():
	engaged_hero = null

func spawn():
	self.connect("do_damage", get_node("/root/Main"), "_on_Villain_do_damage")
	self.connect("villain_selected", get_node("/root/Main"), "_on_Villain_clicked")
	self.connect("villain_dead", get_node("/root/Main"), "_on_Villain_dead")
	$DamageTimer.start()
