extends Node2D


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		save_game()
		print("Saving...")
		await get_tree().create_timer(0.1).timeout
		print("Saved!")
		get_tree().quit()

func save_game():
	ResourceSaver.save(Globals.get_player().postRunResources,"user://01_save.tres")
