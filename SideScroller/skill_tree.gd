extends Control

func _on_exit_button_down():
	# Close menu when exit button is pressed
	queue_free()
