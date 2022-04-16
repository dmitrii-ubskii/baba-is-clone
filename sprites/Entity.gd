extends Node2D

export var entity = EntityEnum.BABA;

func _ready():
	$Sprite.frame = entity
