extends MarginContainer

@onready var timer = %Timer
@onready var label = %Label
@onready var audio_stream_player = $AudioStreamPlayer
@onready var continueArrowContainer = $MarginContainer2

const MAX_WIDTH = 256

var text = String()
var letterIndex = 0

var letterTime = 0.08
var spaceTime = 0.06
var punctuationTime = 0.2

signal finished()

func displayText(textToDisplay: String):
	text = textToDisplay
	label.text = textToDisplay
	await  resized
	custom_minimum_size.x = min(size.x, MAX_WIDTH)
	if size.x > MAX_WIDTH:
		label.autowrap_mode = TextServer.AUTOWRAP_WORD
		await  resized
		custom_minimum_size.y = size.y
	label.text = String()
	displayLetter()
	
func displayLetter():
	audio_stream_player.pitch_scale = randf_range(1,2)
	audio_stream_player.play()
	label.text += text[letterIndex]
	letterIndex += 1
	if letterIndex >= text.length():
		continueArrowContainer.show()
		finished.emit()
		return
	match  text[letterIndex]:
		"!", ".", ",", "?", "¡", "¿":
			timer.start(punctuationTime)
		" ":
			timer.start(spaceTime)
		_:
			timer.start(letterTime)

func _on_timer_timeout():
	displayLetter()
