extends Node

class_name Proyectil

var dir: Vector2 = Vector2(1,0)
@export var speed = 1000

func _process(delta):
	pass
	#self.position += dir * delta * speed
	
func _on_visible_on_screen_enabler_2d_screen_exited():
	print(self)
	print("desaparecio")
	queue_free()
