extends Node2D


# Declare member variables here. Examples:
@onready var generator = $BulletGenerator
var bulletScene = load("res://Entities/Bullet.tscn")
@export var attkSpeed: float = .5
@export var rotationSpeed: float = 0.1
@onready var player = get_parent().get_node("Player")

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.wait_time = attkSpeed
	$Timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func spawnBullets():
	pass

func _on_timer_timeout():
	var b = bulletScene.instantiate()
	b.rotation = generator.rotation
	b.position = position
	b.dir = Vector2(player.position.x - position.x, player.position.y - position.y).normalized()
	get_parent().add_child(b)
