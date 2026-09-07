extends AnimatedSprite2D


# Vanishes When Mouse entered
func _on_mouse_detector_area_mouse_entered() -> void:
	
	z_index = -3


func _on_mouse_detector_area_mouse_exited() -> void:
	
	z_index = 2
