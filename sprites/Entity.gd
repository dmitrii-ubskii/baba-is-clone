extends Node2D

export var entity = EntityEnum.BABA;

signal entity_moved(ref)

func _ready():
	$Sprite.frame = entity

func move(offset):
	self.position += offset
	emit_signal("entity_moved", self)
