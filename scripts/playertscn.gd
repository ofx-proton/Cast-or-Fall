extends CharacterBody2D

const SPEED = 130.0
const JUMP_VELOCITY = -180.0

var is_dead := false
const DEATH_SOUND = preload("res://sprites/brackeys_platformer_assets/sounds/hurt.wav")
const JUMP_SOUND  = preload("res://sprites/brackeys_platformer_assets/sounds/jump.wav")
@onready var audio_player := AudioStreamPlayer.new()

func _ready():
	add_child(audio_player)

func _physics_process(delta):
	if is_dead:
		return

	if not is_on_floor():
		velocity += get_gravity() * delta
	

	

	if Input.is_action_just_pressed("ui_accept"):
		velocity.y = JUMP_VELOCITY
		audio_player.volume_db = -25
		audio_player.stream = JUMP_SOUND
		audio_player.play()



		

	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

	# Kill on any collision
	if get_slide_collision_count() > 0:
		die()
func die():
	if is_dead:
		return

	is_dead = true
	audio_player.stream = DEATH_SOUND
	audio_player.play()
	set_physics_process(false)
	

	await get_tree().create_timer(0.5).timeout

	get_tree().change_scene_to_file("res://scenes/DeathScreen.tscn")
	
func _on_finish_pressed():
	get_tree().change_scene_to_file("res://scenes/won.tscn")
