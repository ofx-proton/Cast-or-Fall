extends Control
func  _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene_to_file("res://scenes/game.tscn")
		
func _on_retry_pressed():
	get_tree().change_scene_to_file("res://scenes/game.tscn")
