extends AnimatedSprite2D


@onready var food_node := $"../../../Food"

var mouse_on_box := false
var potato_scene := preload("res://Scenes/Food/Potato.tscn")
var potato = null

func _process(delta: float) -> void:
	
	if mouse_on_box:
		
		if Input.is_action_just_pressed("any_click"):
			
			if not is_instance_valid(potato):
				potato = potato_scene.instantiate()
				food_node.add_child(potato)
			
			potato.global_position = global_position


func _on_area_2d_mouse_entered() -> void:
	
	mouse_on_box = true


func _on_area_2d_mouse_exited() -> void:
	
	mouse_on_box = false
