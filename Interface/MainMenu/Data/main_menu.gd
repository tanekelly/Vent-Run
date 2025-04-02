extends Control

@onready var texture_rect: TextureRect = $TextureRect

@onready var v_box_container_main_menu: VBoxContainer = $VBoxContainer_MainMenu
@onready var v_box_container_levels: VBoxContainer = $VBoxContainer_Levels


@onready var button: Button = $VBoxContainer/Button
@onready var settings: Button = $VBoxContainer/Settings
@onready var quit: Button = $VBoxContainer/Quit


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Interface/MainMenu/main_menu_levels.tscn")

func _on_settings_pressed() -> void:
	pass # Replace with function body.

func _on_quit_pressed() -> void:
	get_tree().quit();
