extends Node

var score
var tilemap
var budget = 10000
var money_spent = 0
var selected_hero = null
var summary_scene = preload("res://DaySummary.tscn")

func updateDamage(damage):
	money_spent = damage

func _ready():
	tilemap = get_node("/root/Main/TownTileMap")
		
func _on_Villain_do_damage(damage, cell_type_id):
	$HUD.update_damage(damage, cell_type_id)

func _on_HUD_pause_game(isPaused):
	$VillainSpawner.pause(isPaused)
	$Hero.pause(isPaused)

func _on_Hero_clicked(hero):
	selected_hero = hero
	
func _on_Hospital_clicked(hospital):
	if selected_hero:
		selected_hero.move_to_Hospital(hospital)
		selected_hero = null
	
func _on_Villain_clicked(villain):
	if selected_hero:
		selected_hero.move_to_Villain(villain)
		selected_hero = null
		
func _on_Villain_dead(villain, hero):
	hero.stop_attack()
	villain.queue_free()
	$VillainSpawner.on_villain_died()

func _on_Hero_dead(hero, villain):
	villain.stop_attack()
	hero.queue_free()
	
func _calculate_new_path(start_position, target_position, hero):
	var start_road = $TownTileMap.closest_road(start_position)
	var end_road = $TownTileMap.closest_road(target_position)
	var road_path = $TownTileMap.calculate_path(start_road, end_road)
	hero.path = [start_road]
	if road_path:
		road_path.remove(0)
		var path = [start_road] + road_path + [target_position]
		hero.path = path

func _on_HUD_end_of_day():
	var summary = summary_scene.instance()
	summary.set_values(budget, money_spent)	
	add_child(summary)
