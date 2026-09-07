extends AnimatedSprite2D


@onready var cooking_timer = $CookingTimer
@onready var time_clock = $TimeClock
@onready var ticks := $Ticks
@onready var ding := $Ding

var cooking := false
var food = null
var food_type := ""


func _process(delta: float) -> void:
	
	if cooking:
		
		time_clock.value -= delta
		
		if ticks.playing == false:
			
			ticks.playing = true
	
	else:
		
		ticks.playing = false


func _on_area_2d_body_entered(body: Node2D) -> void:
	
	if not "food_type" in body or cooking or not "processed" in body or body.processed:
		
		return
	
	food = body
	
	if food.food_type == "meat":
		
		food.visible = false
		food_type = food.food_type
		cooking = true
		
		cooking_timer.start()
		time_clock.visible = true
		
		# Hide the original food
		if "being_processed" in body:
			
			food.being_processed = true
		




func _on_cooking_timer_timeout() -> void:
	
	# Play the processed animation
	if "sprite" in food and food.sprite and food.distortion:
		
		food.sprite.play("processed_%s" % food.distortion)
	
	if food.particles:
		
		food.particles.emitting = true
	
	ding.play()
	
	# Reset
	food.global_position = global_position
	time_clock.value = time_clock.max_value
	food.visible = true
	food.processed = true
	food.being_processed = false
	food.held_by_mouse = false
	food = null
	food_type = ""
	cooking = false
	time_clock.visible = false
