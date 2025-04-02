extends Control

@onready var texture_rect: TextureRect = $TextureRect

@onready var v_box_container_main_menu: VBoxContainer = $VBoxContainer_MainMenu
@onready var v_box_container_levels: VBoxContainer = $VBoxContainer_Levels

@onready var button: Button = $VBoxContainer/Button
@onready var settings: Button = $VBoxContainer/Settings
@onready var quit: Button = $VBoxContainer/Quit


func _on_floor_2b_pressed() -> void:
	get_tree().change_scene_to_file("res://Stages/LevelB/level_b.tscn")

func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Interface/MainMenu/main_menu.tscn")
