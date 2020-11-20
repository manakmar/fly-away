extends AnimatedSprite

func _on_player_engine_state_changed(running):
	playing = running
	visible = running
