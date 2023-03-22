extends Node2D

var dir: Vector2 = Vector2(1,0)
@export var speed: int = 1000

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.position += dir * delta * speed

func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()
