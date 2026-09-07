extends Camera2D


func _process(_delta: float) -> void:
	
	if Input.is_action_just_pressed("move_left"):
		
		_on_left_button_pressed()
	
	elif Input.is_action_just_pressed("move_right"):
		
		_on_right_button_pressed()
	
	elif Input.is_action_just_pressed("move_down"):
		
		_on_down_button_pressed()
	
	elif Input.is_action_just_pressed("move_up"):
		
		_on_up_button_pressed()


func _on_left_button_pressed() -> void:
	
	if position.x > -125 and position.y == 0:
		
		position.x -= 125


func _on_right_button_pressed() -> void:
	
	if position.x < 125 and position.y == 0:
		
		position.x += 125


func _on_down_button_pressed() -> void:
	
	if position.y < 125 and position.x == 0:
		
		position.y += 125


func _on_up_button_pressed() -> void:
	
	if position.y >= 125 and position.x == 0:
		
		position.y -= 125
