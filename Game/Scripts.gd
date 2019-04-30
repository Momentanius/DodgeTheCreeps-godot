extends CanvasLayer

signal start_game

func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()

#This function is called when the player loses. 
#It will show “Game Over” for 2 seconds, then return to the title screen and,
#after a brief pause, show the “Start” button.
func show_game_over():
	show_message("Game Over!")
	yield($MessageTimer, "timeout")
	$MessageLabel.text = "Dodge the\nCreeps!"
	$MessageLabel.show()
	yield(get_tree().create_timer(1), "timeout") #Cria um timer pelo próprio código
	$StartButton.show()

func update_score(score):
    $ScoreLabel.text = str(score)

func _on_MessageTimer_timeout():
	$MessageLabel.hide()

func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal("start_game")
