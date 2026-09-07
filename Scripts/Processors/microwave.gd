extends AnimatedSprite2D


@onready var microwaving_timer := $MicrowavingTimer
@onready var time_clock := $TimeClock
@onready var ticks := $Ticks
@onready var ding := $Ding

var microwaving := false
var food = null
var food_type := ""


func _process(delta: float) -> void:
	
	if microwaving:
		
		time_clock.value -= delta
		
		if ticks.playing == false:
			
			ticks.playing = true
	
	else:
		
		ticks.playing = false


func _on_area_2d_body_entered(body: Node2D) -> void:
	
	if not "food_type" in body or microwaving or not "processed" in body or body.processed:
		
		return
	
	food = body
	
	if food.food_type == "potato":
		
		food.visible = false
		food_type = food.food_type
		microwaving = true
		
		microwaving_timer.start()
		time_clock.visible = true
		
		# Hide the original food
		if "being_processed" in body:
			
			food.being_processed = true
		




func _on_microwaving_timer_timeout() -> void:
	
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
	microwaving = false
	time_clock.visible = false
