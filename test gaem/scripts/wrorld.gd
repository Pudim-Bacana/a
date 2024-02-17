extends Node2D

var borders = Rect2(1, 1, 26, 13)

@onready var tilemap = $TileMap

func _ready():
	randomize()
	generate_level()

func generate_level():
	var walker = Walker.new(Vector2(13, 7), borders)
	var map = walker.walk(500)
	walker.queue_free()
	for location in map:
		tilemap.erase_cell(0, location)
	var used_cells = tilemap.get_used_cells(0)
	tilemap.set_cells_terrain_connect(0, used_cells, 0, 0)


func _input(event):
	if event.is_action_pressed("ui_accept"):
		get_tree().reload_current_scene()
