extends Control

@export var player: Player
var playerStats
var playerResources
var playerPostRunRes

func _ready():
	playerStats = player.playerStats
	playerResources = player.playerResources
	playerPostRunRes = player.postRunResources
	if playerStats:
		# Set up defaults for health bar
		%HealthBar.max_value = playerStats.MAX_HEALTH
		%HealthBar.value = playerStats.CURR_HEALTH
	if playerResources:
		%SilverLabel.text = "Silver: " + str(playerResources.silver)
	if playerPostRunRes:
		%SkillPoints.text = "Skill Points: " + str(playerPostRunRes.skill_points)
		

func _on_player_health_changed(val: int):
	%HealthBar.value = val


func _on_player_silver_changed(val: int):
	%SilverLabel.text = "Silver: " + str(val)
