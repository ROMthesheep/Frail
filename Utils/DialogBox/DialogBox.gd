extends ColorRect

@export var dialogPath = ""
@export var textSpd: float = 0.05

var dialog

var phraseNum = 0
var finished = false

var dotTimer = 0

func _ready():
	$Timer.wait_time = textSpd
	dialog = getDialog()
	assert(dialog, "no se encontro contenido")
	nextPhrase()

func _process(delta):
	animateDots()
	if Input.is_action_just_pressed("ui_accept"):
		if finished:
			nextPhrase()

func getDialog() -> Array:
	var rawJson = FileAccess.open(dialogPath, FileAccess.READ).get_as_text()
	var output = JSON.parse_string(rawJson)

	return output if typeof(output) == TYPE_ARRAY else []
	
func animateDots():
	if finished:
		$ContinueText/AnimationPlayer.play("NextPage")
	else:
		$ContinueText/AnimationPlayer.play("RESET")


func nextPhrase() -> void:
	if phraseNum >= len(dialog):
		queue_free()
		return

	finished = false
	$Name.bbcode_text = dialog[phraseNum]["Nombre"]
	$Contents.bbcode_text = dialog[phraseNum]["Texto"]

	$Contents.visible_characters = 0

	while $Contents.visible_characters < len($Contents.text):
		$Contents.visible_characters += 1

		$Timer.start()
		await($Timer.timeout)

	finished = true
	phraseNum += 1
	return
