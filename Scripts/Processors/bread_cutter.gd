extends Sprite2D


@onready var cutting_timer = $CuttingTimer
@onready var time_clock = $TimeClock
@onready var food_guillotine = $Guillotine
@onready var ticks := $Ticks
@onready var ding := $Ding


var cutting := false
var food = null
var food_type := ""


func _process(delta: float) -> void:
	
	if cutting:
		
		food_guillotine.position.y += 0.015
		time_clock.value -= delta


func _on_area_2d_body_entered(body: Node2D) -> void:
	
	if not "food_type" in body or cutting or not "processed" in body or body.processed:
		
		return
	
	food = body
	
	if food.food_type == "bread" or food.food_type == "tomato":
		
		food.global_position = global_position + Vector2(0, 10)
		food_type = food.food_type
		cutting = true
		
		cutting_timer.start()
		time_clock.visible = true
		
		# Hide the original food
		if "being_processed" in body:
			
			food.being_processed = true
		




func _on_cutting_timer_timeout() -> void:
	
	# Play the processed animation
	if "sprite" in food and food.sprite and food.distortion:
		
		food.sprite.play("processed_%s" % food.distortion)
	
	ding.play()
	
	# Reset
	time_clock.value = time_clock.max_value
	food.processed = true
	food.being_processed = false
	food.held_by_mouse = false
	food = null
	food_type = ""
	cutting = false
	time_clock.visible = false
	food_guillotine.position = Vector2(0, 0)
