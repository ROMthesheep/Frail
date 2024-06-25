extends Node

@onready var dialogBoxScene  = preload("res://Misc/Sistema de dialogos/DialogBox.tscn")

var dialogLines: Array[String] = []
var currentLineIndex = 0

var textBox
var textBoxPosition: Vector2

var isDialogActive = false
var canAdvanceLine = false
var speaker = null

signal conversation_ended(node)

func npc_talking(npc: Node, lines: Array[String]):
	speaker = npc
	startDialog(npc.position + Vector2(-8,30), lines)

func startDialog(position: Vector2, lines: Array[String]):
	if isDialogActive:
		return
	dialogLines = lines
	textBoxPosition = position
	showTextBox()
	isDialogActive = true

func showTextBox():
	textBox = dialogBoxScene.instantiate()
	textBox.finished.connect(textBoxFinishedDisplaying);
	get_tree().current_scene.add_child(textBox)
	textBox.global_position = textBoxPosition
	textBox.displayText(dialogLines[currentLineIndex])
	canAdvanceLine = false
	
func textBoxFinishedDisplaying():
	canAdvanceLine = true
	
func _unhandled_input(event):
	if(event.is_action_pressed("advanceDialog") && isDialogActive && canAdvanceLine):
		textBox.queue_free()
		currentLineIndex += 1
		if currentLineIndex >= dialogLines.size():
			isDialogActive = false
			currentLineIndex = 0
			conversation_ended.emit(speaker)
			speaker = null
			return
		showTextBox()
