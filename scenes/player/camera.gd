extends Camera2D

@export var select:RigidBody2D = null
@export var backgrounds:Node2D = null

func _process(_delta):
	if select.fin and global_position.x < select.global_position.x and select.global_position.y < 1000:
		global_position.x = select.global_position.x
		backgrounds.modulate.r = select.global_position.x*0.0005
	elif select.fin and select.global_position.y >= 1000:
		select.freeze = true
		select.fin = true
		select.position = Vector2(-711, -550)
		select.inertia = 0
		select.linear_velocity = Vector2(0, 0)
		position.x = 0
		
		var tween = get_tree().create_tween()
		tween.parallel().tween_property(select, "position", Vector2(-711, -550), 1.0)
		tween.parallel().tween_property(backgrounds, "modulate:a", 0.0 , 0.5)
		tween.parallel().tween_property(backgrounds, "modulate:r", 0.0 , 0.5)
