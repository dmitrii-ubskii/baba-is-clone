extends Node2D

var Entity = preload("res://sprites/Entity.tscn")

var rules = []

onready var cell_size = $TileMap.cell_size

func _ready():
	for tile in $TileMap.get_used_cells():
		var entity = Entity.instance()
		entity.position = tile * cell_size
		entity.entity = $TileMap.get_cellv(tile)
		var _error = entity.connect("entity_moved", self, "_on_move")
		add_child(entity)
	$TileMap.free()
	_update_rules()

func _try_read_rule(dict, start, direction):
	if not start + direction in dict:
		return null
	if dict[start+direction] != EntityEnum.CONTROL_IS:
		return null
	var end = start + 2 * direction
	if not end in dict:
		return null
	match dict[end]:
		EntityEnum.PRED_STOP, \
		EntityEnum.PRED_WIN, \
		EntityEnum.PRED_YOU:
			return Rule.new(dict[start], dict[end])
		_:
			return null

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
				var rule = _try_read_rule(text, pos, Vector2.DOWN)
				if rule != null:
					rules.append(rule)
				rule = _try_read_rule(text, pos, Vector2.RIGHT)
				if rule != null:
					rules.append(rule)
	for rule in rules:
		print(rule.format())

func _input(event):
	var move_direction = Vector2.ZERO
	if event.is_action_pressed("ui_up"):
		move_direction = Vector2.UP
	if event.is_action_pressed("ui_down"):
		move_direction = Vector2.DOWN
	if event.is_action_pressed("ui_left"):
		move_direction = Vector2.LEFT
	if event.is_action_pressed("ui_right"):
		move_direction = Vector2.RIGHT
	
	if move_direction != Vector2.ZERO:
		# we movin'
		for entity in get_children():
			entity.move(move_direction * cell_size)
		get_tree().set_input_as_handled()

func _on_move(_who):
	pass
