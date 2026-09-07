extends Sprite2D

@export var shake_amount := 0.1
@export var shake_speed := 0.1

var original_position: Vector2

func _ready():
	original_position = position

func _process(delta):
	var offset = Vector2(
		randf_range(-shake_amount, shake_amount),
		randf_range(-shake_amount, shake_amount)
	)

	position = original_position + offset
