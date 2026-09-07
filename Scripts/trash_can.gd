extends Sprite2D


func _on_area_2d_body_entered(body: Node2D) -> void:
	print("Entered: ", body)
	print("Groups: ", body.get_groups())

	if body.is_in_group("Food"):
		print("DELETING: ", body)
		body.queue_free()
