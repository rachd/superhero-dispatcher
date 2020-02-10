extends Node

var score
var tilemap

var selected_hero = null

func _ready():
	tilemap = get_node("/root/Main/TownTileMap")
		
func _on_Villain_do_damage(damage, cell_type_id):
	$HUD.update_damage(damage, cell_type_id)


func _on_HUD_pause_game(isPaused):
	$VillainSpawner.pause(isPaused)
	$Hero.pause(isPaused)

func _on_Hero_clicked(hero):
	selected_hero = hero
	
func _on_Villain_clicked(villain):
	if selected_hero:
		selected_hero.move_to_Villain(villain)
		selected_hero = null
