extends Node2D

var player_score = 0;
var lives = 3;

@onready var heart_one: Polygon2D = %HeartOne
@onready var heart_two: Polygon2D = %HeartTwo
@onready var heart_three: Polygon2D = %HeartThree

@onready var score_value: Label = $UI/GameOverScreen/ScoreValue
@onready var game_over_screen: Panel = %GameOverScreen
@onready var highest_score_value: Label = $UI/GameOverScreen/HighestScoreValue

@onready var score_audio_player: AudioStreamPlayer2D = %ScoreAudioPlayer
@onready var game_over_audio_player: AudioStreamPlayer2D = %GameOverAudioPlayer
@onready var lost_life_audio_player: AudioStreamPlayer2D = %LostLifeAudioPlayer

func _on_static_body_bottom_body_entered(body: Node2D) -> void:
	if body is Ball:
		lives -=1;
		
		if lives == 2:
			heart_three.visible = false
		elif lives == 1:
			heart_two.visible = false
		else:
			heart_one.visible = false
		
		if lives <= 0:
			game_over_audio_player.play()
			game_over_screen.visible = true
			get_tree().paused = true
		else:
			body.flip_ball()
			lost_life_audio_player.play()

func _on_restart_button_pressed() -> void:
	get_tree().paused = false
	game_over_screen.visible = false
	get_tree().reload_current_scene()

func _on_ball_player_scored() -> void:
	score_audio_player.play()
	player_score += 1;
	
	if Global.highest_score < player_score:
		Global.highest_score = player_score;
	
	score_value.text = str(player_score)
	highest_score_value.text = str(Global.highest_score)
