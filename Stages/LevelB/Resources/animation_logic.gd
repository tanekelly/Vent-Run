extends Node

var animated_sprites: Dictionary
var two_frame: Dictionary

func _ready() -> void:
	animated_sprites = {}
	two_frame = {}

	_gather_animated_sprites(get_tree().root)

	_setup_sprites(animated_sprites, 0.6)
	_setup_sprites(two_frame, 0.3)

func _gather_animated_sprites(node: Node) -> void:
	for child in node.get_children():
		if child is AnimatedSprite2D:
			if child.name.ends_with("_AnimTwo"):
				two_frame[child.name] = child
			elif child.name.ends_with("_Anim"):
				animated_sprites[child.name] = child
		_gather_animated_sprites(child)

func _setup_sprites(sprites: Dictionary, speed: float) -> void:
	for sprite in sprites.values():
		sprite.frame = 0
		sprite.speed_scale = speed
		sprite.play()
