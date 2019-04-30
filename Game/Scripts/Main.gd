extends Node2D

export (PackedScene) var Mob

var score = 0

func _ready():
	randomize()

#game over
func _on_Player_hit(): 
	$Timers/ScoreTimer.stop()
	$Timers/MobTimer.stop()
	$HUD.show_game_over()

func new_game():	
	score = 0
	$HUD.update_score(score)
	$Player.start($StartPosition.position)
	$Timers/StartTimer.start()
	$HUD.show_message("Get Ready")

func _on_MobTimer_timeout():
	# Choose a random location on Path2D.
    $MobSpawn/MobSpawnLocation.set_offset(randi())
    # Create a Mob instance and add it to the scene.
    var mob = Mob.instance()
    add_child(mob)
    # Set the mob's direction perpendicular to the path direction.
    var direction = $MobSpawn/MobSpawnLocation.rotation + PI / 2
    # Set the mob's position to a random location.
    mob.position = $MobSpawn/MobSpawnLocation.position
    # Add some randomness to the direction.
    direction += rand_range(-PI / 4, PI / 4)
    mob.rotation = direction
    # Set the velocity (speed & direction).
    mob.linear_velocity = Vector2(rand_range(mob.min_speed, mob.max_speed), 0)
    mob.linear_velocity = mob.linear_velocity.rotated(direction)


func _on_StartTimer_timeout():
	$Timers/MobTimer.start()
	$Timers/ScoreTimer.start()

func _on_ScoreTimer_timeout():
	score +=1
	$HUD.update_score(score)

func _on_HUD_start_game():
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	new_game()
