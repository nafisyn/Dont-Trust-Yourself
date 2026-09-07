extends Node2D

@onready var body: Sprite2D = $Body
@onready var head: Sprite2D = $Head
@onready var hair: Sprite2D = $Hair
@onready var order_sprite: Sprite2D = $OrderSprite
@onready var talk_audio := $TalkAudio


const HEADS := [
	Rect2(0, 64, 32, 32),
	Rect2(32, 64, 32, 32),
	Rect2(64, 64, 32, 32),
	Rect2(96, 64, 32, 32),
	Rect2(128, 64, 32, 32),
	Rect2(160, 64, 32, 32),
	Rect2(192, 64, 32, 32),
	Rect2(224, 64, 32, 32),
	Rect2(256, 64, 32, 32),
	Rect2(288, 64, 32, 32),

	Rect2(0, 96, 32, 32),
	Rect2(32, 96, 32, 32),
	Rect2(64, 96, 32, 32),
	Rect2(96, 96, 32, 32),
	Rect2(128, 96, 32, 32),
	Rect2(160, 96, 32, 32),
	Rect2(192, 96, 32, 32),
	Rect2(224, 96, 32, 32),
	Rect2(256, 96, 32, 32),
	Rect2(288, 96, 32, 32)
]


const HAIR := [
	Rect2(0, 128, 32, 32),
	Rect2(32, 128, 32, 32),
	Rect2(64, 128, 32, 32),
	Rect2(96, 128, 32, 32),
	Rect2(128, 128, 32, 32),
	Rect2(160, 128, 32, 32)
]


const BODIES := [
	Rect2(192, 128, 32, 32),
	Rect2(224, 128, 32, 32),
	Rect2(256, 128, 32, 32),
	Rect2(288, 128, 32, 32)
]


# Sandwich orders
# Each one ALWAYS contains bread.
const ORDERS := [
	["bread", "meat"],
	["bread", "meat", "cheese"],
	["bread", "meat", "lettuce"],
	["bread", "meat", "cheese", "lettuce"],
	["bread", "cheese"]
]


# Matching sprites from the order spritesheet.
# These are the 5 sandwiches on row 3.
const ORDER_REGIONS := [
	Rect2(0, 64, 32, 32),
	Rect2(32, 64, 32, 32),
	Rect2(64, 64, 32, 32),
	Rect2(96, 64, 32, 32),
	Rect2(128, 64, 32, 32)
]


# Potato is completely separate.
const POTATO_ORDER := ["potato"]


var order = []

var normal_head_index: int
var talking := false
var hair_base_position: Vector2


func _ready() -> void:
	head.region_enabled = true
	hair.region_enabled = true
	body.region_enabled = true
	print(order_sprite)
	order_sprite.region_enabled = true

	hair_base_position = hair.position

	randomize_npc()
	make_random_order()


func randomize_npc() -> void:
	# Pick ONLY normal heads.
	# 0, 2, 4, 6... are the normal versions.
	normal_head_index = randi_range(0, 9) * 2

	head.region_rect = HEADS[normal_head_index]

	hair.region_rect = HAIR.pick_random()
	body.region_rect = BODIES.pick_random()

	talking = false
	hair.position = hair_base_position


func make_random_order() -> void:
	# 1 in 6 chance to order potato.
	if randi_range(0, 5) == 0:
		order = POTATO_ORDER.duplicate()

		order_sprite.region_enabled = true
		order_sprite.region_rect = Rect2(64, 32, 32, 32)
		order_sprite.visible = false

		print("Order: ", order)
		return

	# Otherwise pick a random sandwich.
	var order_index := randi_range(0, ORDERS.size() - 1)

	order = ORDERS[order_index].duplicate()

	order_sprite.region_enabled = true
	order_sprite.region_rect = ORDER_REGIONS[order_index]
	order_sprite.visible = false

	print("Order: ", order)



func start_talking() -> void:
	if talking:
		return
	
	talking = true
	order_sprite.visible = true
	_talk_animation()
	talk_audio.playing = true



func stop_talking() -> void:
	talking = false

	# Return to normal head
	head.region_rect = HEADS[normal_head_index]

	# Return hair to original position
	hair.position = hair_base_position
	talk_audio.playing = false


func _talk_animation() -> void:
	while talking:
		# Talking head
		head.region_rect = HEADS[normal_head_index + 1]

		# Hair moves DOWN 0.5 pixels
		hair.position.y = hair_base_position.y + 0.5

		await get_tree().create_timer(0.10).timeout

		if not talking:
			break

		# Normal head
		head.region_rect = HEADS[normal_head_index]

		# Hair moves UP 0.5 pixels
		hair.position.y = hair_base_position.y - 0.5

		await get_tree().create_timer(0.10).timeout
