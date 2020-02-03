extends Node

var score
var tilemap

func _ready():
	tilemap = get_node("/root/Main/TownTileMap")
		
func _on_Villain_do_damage(damage, cell_type_id):
	$HUD.update_damage(damage, cell_type_id)


func _on_HUD_pause_game(isPaused):
	$VillainSpawner.pause(isPaused)
