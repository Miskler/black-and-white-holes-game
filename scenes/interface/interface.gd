extends CanvasLayer


func _ready():
	$management/text.text = "Управление -  UP/SPACE/W\nЛибо нажми на экран :)"
	$management/jam_link.hide()
	
	await push().finished
	
	$management.modulate.r = 0
	$management/wait_bar.value = 0
	$management/text.text = "Сделано специально\nдля этого геймджема"
	$management/jam_link.show()
	
	await push().finished
	
	$management.modulate.r = 1
	$management.modulate.b = 0
	$management/wait_bar.value = 0
	$management/text.text = "Включить режим\nсовместимости"
	$management/jam_link.hide()
	$management/compatibility_mode.show()
	
	push()

func push() -> Tween:
	$management/push.play()
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_CIRC)
	tween.tween_property($management, "position:x", 666, 0.5)
	tween.tween_property($management/wait_bar, "value", 100.0, 5.0)
	tween.tween_property($management, "position:x", 1200, 0.5)
	return tween


var sost = false
func _process(_delta):
	var press_keyboard = Input.is_action_pressed("ui_up")
	var press_ui = get_node("/root/main/camera/interface/ui_button").button_pressed
	
	var press = press_keyboard or press_ui
	
	if sost and press:
		sost = false
		$holes_reset.play()
		$condition_holes/reset_condition.play("def")
	elif not sost and not press:
		sost = true
		$holes_reset.play()
		$condition_holes/reset_condition.play_backwards("def")


func win():
	$holes_reset.volume_db = -80
	get_node("/root/main/ost_win").play()
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_ELASTIC)
	tween.parallel().tween_property($condition_holes, "modulate:a", 0.0 , 0.5)
	tween.parallel().tween_property(get_node("/root/main/ost_game"), "volume_db", -80.0 , 0.5)
	tween.parallel().tween_method(set_shader_value, 1.2, 3, 1.5)
	tween.tween_property($win_label, "position:y", 110.0 , 1.0)


func set_shader_value(value: float):
	$transition.material.set_shader_parameter("right", value)
	$transition.material.set_shader_parameter("left", -(value-2.5))


func jam_link_pressed():
	OS.shell_open("https://itch.io/jam/how-about-make-game")


func compatibility_mode_pressed():
	Global.emit_signal("compatibility_mode")
