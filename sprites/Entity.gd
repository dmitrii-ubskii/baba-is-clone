extends Node2D

export var entity = EntityEnum.BABA;
var push = false setget set_push

signal entity_moved(ref)

func _ready():
	$Sprite.frame = entity

func move(offset):
	self.position += offset
	emit_signal("entity_moved", self)

func set_push(value):
	push = value
	$KinematicBody2D/CollisionShape2D.disabled = not push	
