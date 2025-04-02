extends Button

@export var hover_scale: float = 1.1
@export var animation_duration: float = 0.5
@export var spring_strength: float = 0.15

var default_scale: Vector2
var tween: Tween

func _ready() -> void:
	default_scale = scale
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	# Connect to focus changes
	get_tree().root.focus_exited.connect(_on_window_focus_exited)

func _exit_tree() -> void:
	if get_tree().root:
		get_tree().root.focus_exited.disconnect(_on_window_focus_exited)

func _on_window_focus_exited() -> void:
	# If we're in a hover state when focus is lost, reset the button
	if tween and tween.is_valid():
		tween.kill()
		scale = default_scale
		# Reset position to default
		var original_button = get_parent().get_node_or_null(NodePath(self.name))
		if original_button:
			position = original_button.position

func _process(delta: float) -> void:
	pass

func _on_mouse_entered() -> void:
	if tween:
		tween.kill()
	
	var start_pos = position
	var start_scale = scale
	var target_scale = default_scale * hover_scale
	var scale_factor = target_scale / start_scale
	
	tween = create_tween()
	tween.set_trans(Tween.TRANS_ELASTIC)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "scale", target_scale, animation_duration)
	# Adjust position to maintain center during scale
	var offset = size * (scale_factor - Vector2.ONE) / 2
	tween.parallel().tween_property(self, "position", start_pos - offset, animation_duration)

func _on_mouse_exited() -> void:
	if tween:
		tween.kill()
	
	var start_pos = position
	var start_scale = scale
	
	tween = create_tween()
	tween.set_trans(Tween.TRANS_ELASTIC)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "scale", default_scale, animation_duration)
	# Adjust position to maintain center during scale
	var offset = size * (start_scale / default_scale - Vector2.ONE) / 2
	tween.parallel().tween_property(self, "position", start_pos + offset, animation_duration) 