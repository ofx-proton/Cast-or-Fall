extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -180.0

var is_dead := false

func _physics_process(delta):
	if is_dead:
		return

	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("ui_accept"):
		velocity.y = JUMP_VELOCITY

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
	set_physics_process(false)

	await get_tree().create_timer(0.1).timeout

	get_tree().change_scene_to_file("res://scenes/DeathScreen.tscn")
