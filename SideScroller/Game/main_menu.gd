extends Control
class_name MainMenu

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()

func _on_start_button_down():
	get_tree().change_scene_to_file("res://Levels/lobby.tscn")

func _on_quit_button_down():
	get_tree().quit()

func _on_coop_button_down():
	pass # Replace with function body.

func _on_settings_button_down():
	pass # Replace with function body.
