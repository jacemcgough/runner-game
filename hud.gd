extends CanvasLayer

signal start_game

func show_message(text = ''):
    if !!text:
        $Message.text = text
        $Message.show()
    $MessageTimer.start()

func show_game_over():
    show_message('Game Over')

    await get_tree().create_timer(2).timeout
    $StartButton.show()

func update_score(score):
    $ScoreLabel.text = str(score)

func _on_start_button_pressed():
    $StartButton.hide()
    start_game.emit()

func _on_message_timer_timeout():
    $Message.hide()
