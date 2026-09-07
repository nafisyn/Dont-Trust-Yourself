extends CharacterBody2D


@onready var sprite := $Icon
@onready var animation_timer1 := $Timers/AnimationTimer1
@onready var animation_timer2 := $Timers/AnimationTimer2
@onready var self_node := $"."
@onready var collision_shape := $Collision
@onready var particles := get_node_or_null("GPUParticles2D")

@export var food_type := "food"
@export var processed := false

var mouse_on_object := false
var held_by_mouse := false
var skew_value := 0.01
var being_processed := false
var distortion := "normal"

signal object_held
signal object_dropped


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
		# Dragging
	if mouse_on_object:
		
		if Input.is_action_pressed("any_click") and not being_processed:
			object_held.emit(self_node)
			held_by_mouse = true
		
		else:
			
			object_dropped.emit()
			held_by_mouse = false

	
	if held_by_mouse and not being_processed:
		
			position = get_global_mouse_position()
	
	# Gravity
	if not held_by_mouse:
		
		if being_processed:
			
			return
		
		velocity += get_gravity() * delta
		
		move_and_slide()


# Dragging
func _on_area_2d_mouse_entered() -> void:
	
	mouse_on_object = true


func _on_area_2d_mouse_exited() -> void:
	
	mouse_on_object = false


# Animation
func _on_animation_timer_1_timeout() -> void:
	
	sprite.skew = skew_value
	animation_timer2.start()


func _on_animation_timer_2_timeout() -> void:
	
	sprite.skew = -skew_value
	animation_timer1.start()
