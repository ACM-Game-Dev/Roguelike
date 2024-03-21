extends ProgressBar

@export var player: Player
var playerStats

func _ready():
	playerStats = player.playerStats
	if playerStats:
		max_value = playerStats.MAX_HEALTH
		value = playerStats.CURR_HEALTH
		

func _on_player_health_changed():
	value = playerStats.CURR_HEALTH
