extends TextureButton


@onready var animation_timer1 = $AnimationTimer1
@onready var animation_timer2 = $AnimationTimer2

var skew_value = 0.001


# Animation
func _on_animation_timer_1_timeout() -> void:
	
	rotation = skew_value
	animation_timer2.start()
	animation_timer1.wait_time = 0.2


func _on_animation_timer_2_timeout() -> void:
	
	rotation = -skew_value
	animation_timer1.start()
