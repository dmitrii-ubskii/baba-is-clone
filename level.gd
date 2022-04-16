extends Node2D

var Entity = preload("res://sprites/Entity.tscn")

var rules = []

onready var cell_size = $TileMap.cell_size

func _ready():
	for tile in $TileMap.get_used_cells():
		var entity = Entity.instance()
		entity.position = tile * cell_size
		entity.entity = $TileMap.get_cellv(tile)
		add_child(entity)
	$TileMap.free()
	_update_rules()

func _update_rules():
	rules.clear()
	var text = {}
	for entity in get_children():
		match entity.entity:
			EntityEnum.TEXT_BABA, \
			EntityEnum.TEXT_FLAG, \
			EntityEnum.TEXT_WALL, \
			EntityEnum.PRED_STOP, \
			EntityEnum.PRED_WIN, \
			EntityEnum.PRED_YOU, \
			EntityEnum.CONTROL_IS:
				var cell = entity.position / cell_size
				text[cell] = entity.entity
	for pos in text:
		match text[pos]:
			EntityEnum.TEXT_BABA, \
			EntityEnum.TEXT_FLAG, \
			EntityEnum.TEXT_WALL:
				if pos + Vector2.DOWN in text:
					var next = pos + Vector2.DOWN
					if text[next] == EntityEnum.CONTROL_IS:
						next += Vector2.DOWN
						if next in text:
							match text[next]:
								EntityEnum.PRED_STOP, \
								EntityEnum.PRED_WIN, \
								EntityEnum.PRED_YOU:
									rules.append(Rule.new(text[pos], text[next]))
				if pos + Vector2.RIGHT in text:
					var next = pos + Vector2.RIGHT
					if text[next] == EntityEnum.CONTROL_IS:
						next += Vector2.RIGHT
						if next in text:
							match text[next]:
								EntityEnum.PRED_STOP, \
								EntityEnum.PRED_WIN, \
								EntityEnum.PRED_YOU:
									rules.append(Rule.new(text[pos], text[next]))
	for rule in rules:
		print(rule.format())
