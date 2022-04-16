extends Node2D

var Entity = preload("res://sprites/Entity.tscn")

func _ready():
	for tile in $TileMap.get_used_cells():
		var entity = Entity.instance()
		entity.position = tile * $TileMap.cell_size
		entity.entity = $TileMap.get_cellv(tile)
		add_child(entity)
	$TileMap.queue_free()
