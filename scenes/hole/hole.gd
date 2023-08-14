extends Area2D

func _process(_delta):
	var press_keyboard = Input.is_action_pressed("ui_up")
	var press_ui = get_node("/root/main/camera/interface/ui_button").button_pressed
	
	var press = press_keyboard or press_ui
	
	var tween = get_tree().create_tween()
	tween.parallel().tween_property(self, "gravity", {true: 4096, false: -4096}[press], 0.1)
	tween.parallel().tween_property($distortion/center, "modulate", {true: Color("000000"), false: Color("ffffff")}[press], 0.1)
	tween.parallel().tween_method(set_shader_value, $distortion.material.get_shader_parameter("strength"), {true: 0.2, false: -0.2}[press], 0.1)


func set_shader_value(value: float):
	$distortion.material.set_shader_parameter("strength", value);
