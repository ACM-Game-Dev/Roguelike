extends Node

var player: Player = null

func get_player():
	return player

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		LoadSaver.save()
		get_tree().quit()

func _notification(msg):
	if msg == NOTIFICATION_WM_CLOSE_REQUEST:
		LoadSaver.save()
		print("You are quit!")

