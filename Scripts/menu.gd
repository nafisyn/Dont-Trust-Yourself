extends Node2D


@onready var camera = $Camera


func _on_texture_button_pressed() -> void:
	
	get_tree().change_scene_to_file("res://Scenes/Main.tscn")


func _on_distort_timer_1_timeout() -> void:
	
	var distortables = get_tree().get_nodes_in_group("Distortable")
	
	for distortable in distortables:
		 
		distortable.play("distorted_10")
	
	$DistortTimer2.start()


func _on_distort_timer_2_timeout() -> void:
	
	var distortables = get_tree().get_nodes_in_group("Distortable")
	
	for distortable in distortables:
		 
		distortable.play("distorted_0")
	
	$DistortTimer3.start()


func _on_distort_timer_3_timeout() -> void:
	
	var distortables = get_tree().get_nodes_in_group("Distortable")
	
	for distortable in distortables:
		 
		distortable.play("normal")
	
	$DistortTimer1.start()
	
