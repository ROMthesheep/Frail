extends Node2D

@onready var label: Label = $Label
@onready var player = $Player
@onready var npc = $Npc
const DIALOG_BOX = preload("res://Misc/Sistema de dialogos/DialogBox.tscn")

var lines: Array[String] =  [
		"Lo siento, esto no va a funcionar",
		"Siempre supimos que esto no iba para largo",
		"No me busques",
		"No voy a cambiar de opinion",
		"Ademas juegas solo personajes femeninos con enormes tetas en el lol, me das asco",
	]
# Called when the node enters the scene tree for the first time.
func _ready():
	DialogManager.conversation_ended.connect(eyyy)
	DialogManager.npc_talking(npc, lines)

func eyyy(node):
	if node != null:
		node.queue_free()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
