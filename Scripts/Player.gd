extends Node2D
 
var _is_dead = false
var _can_be_hurted = true
var _last_position: Vector2

var health = 3

const CORAZON_1_HP = preload("res://Assets/Sprites/Corazon_1_hp.tres")
const CORAZON_2_HP = preload("res://Assets/Sprites/Corazon_2_hp.tres")
const CORAZON_3_HP = preload("res://Assets/Sprites/Corazon_3_hp.tres")
const DEAD_PLAYER = preload("res://Assets/Sprites/DeadPlayer.tres")

@onready var sprite = $Sprite2D
@onready var label = $Label
@onready var heartbeat = $Heartbeat
@onready var animation_tree = $Sprite2D/AnimationTree
@onready var hurtSound = $Hurt
@onready var hurt_cd = $HurtCD
@onready var healSound = $Heal
@onready var sangrado_constante = $SangradoConstante
@onready var hurt_particles = $HurtParticles

signal player_died

func _ready():
	update_health()
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _process(delta):
	if not _is_dead:
		self.position = get_global_mouse_position()
	checkMouseSpeed()

func update_health():
	sprite.scale = Vector2(1, 1)
	match health:
		3:
			sprite.texture = CORAZON_3_HP
		2:
			sprite.texture = CORAZON_2_HP
		1:
			sprite.texture = CORAZON_1_HP

func _on_area_player_area_entered(area):
	if area is Proyectil:
		hurt()
	elif area is Love:
		heal()
	else:
		pass

func checkMouseSpeed():
	var lastMouseSpeed = Input.get_last_mouse_velocity()
	var speed = sqrt(lastMouseSpeed.x * lastMouseSpeed.x + 2 * lastMouseSpeed.y)
	label.text = str(int(speed))
	if speed > 500 and not _is_dead and _can_be_hurted:
		hurt()
		
func heal():
	if health < 3:
		healSound.play()
		health += 1
		update_health()

func hurt():
	if health > 0 and _can_be_hurted:
		hurtSound.play()
		_last_position = position
		_is_dead = false
		_can_be_hurted = false
		health -= 1
		hurt_cd.start()
		if health == 0:
			die()
		else:
			update_health()
			hurt_particles.emitting = true

func die():
	self.position = _last_position
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	self.position = _last_position
	heartbeat.stop()
	animation_tree.stop()
	sprite.scale = Vector2(3, 3)
	sprite.texture = DEAD_PLAYER
	_is_dead = true

func _on_audio_stream_player_finished():
	heartbeat.play()
	animation_tree.play("dokidoki")


func _on_hurt_cd_timeout():
	_can_be_hurted = true
