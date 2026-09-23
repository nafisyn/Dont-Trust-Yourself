extends Sprite2D


@onready var bag_sfx = $BagSFX

var ingredients := []


func _on_area_2d_body_entered(body: Node2D) -> void:
	
	if body.is_in_group("Food"):
		
		if not body.food_type in ingredients and body.processed:
			
			ingredients.append(body.food_type)
			body.queue_free()
			bag_sfx.play()
			print(ingredients)
