extends Node2D

export var damage = 100

signal do_damage(damage)

func do_damage():
	var position = self.position
	var tilemap = get_node("/root/Main/TownTileMap")
	var cell_coord = tilemap.world_to_map(position)
	var cell_type_id = tilemap.get_cellv(cell_coord)
	emit_signal("do_damage", damage, cell_type_id)

func _on_DamageTimer_timeout():
	do_damage()

func pause(isPaused):
	$DamageTimer.set_paused(isPaused)

func spawn():
	self.connect("do_damage", get_node("/root/Main"), "_on_Villain_do_damage")
	$DamageTimer.start()
