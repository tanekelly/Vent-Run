extends Node2D

@onready var entrance_door: AnimatedSprite2D = $Background/EntranceDoor/EntranceDoor
@onready var alarm: AnimatedSprite2D = $Background/EntranceDoor/Alarm

var animated_sprites: Dictionary

func _ready() -> void:
	animated_sprites = {
		"entrance_door": entrance_door,
		"alarm": alarm,
	}
	
	for sprite in animated_sprites.values():
		sprite.frame = 0
		sprite.speed_scale = 0.6
		sprite.play()
