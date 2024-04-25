extends Node

const SAVE_FILEPATH = "user://save_1.tres"

func save():
	ResourceSaver.save(Globals.get_player().postRunResource,SAVE_FILEPATH)

func load_player_resource(player: Player):
	player.postRunResource = load(SAVE_FILEPATH)
