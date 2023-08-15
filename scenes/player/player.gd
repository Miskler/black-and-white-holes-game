extends RigidBody2D

var finish = 8200

var fin = true
func _process(_delta):
	var press = get_node("../camera/interface/ui_button").button_pressed
	
	if (Input.is_action_just_pressed("ui_up") or press) and freeze: start()
	
	if fin and global_position.y < 1000 and finish <= global_position.x:
		fin = false
		var tween = get_tree().create_tween()
		tween.tween_property($"../win_label", "modulate:a", 0.0 , 0.1)
		await tween.finished
		$"../camera/interface".win()

func start():
	freeze = false
	var tween = get_tree().create_tween()
	tween.tween_property($"../backgrounds", "modulate:a", 1.0 , 0.5)
