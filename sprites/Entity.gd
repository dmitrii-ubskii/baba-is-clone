extends Node2D

enum Entity {
	BABA, WALL, FLAG,
	TEXT_BABA, TEXT_WALL, TEXT_FLAG,
	PRED_YOU, PRED_STOP, PRED_WIN,
	CONTROL_IS,
}

export(Entity) var entity;

func _ready():
	$Sprite.frame = entity
