extends Node2D
## TO DO
## Music and SFX -
## Distortions
## Tutorials
## Menu -


#region Variables and Constants

@onready var customer = $Customer
@onready var customer_spawn = customer.global_position
@onready var next_position = $CustomerNextPosition
@onready var next_positions_original_position = next_position.global_position
@onready var next_positions_next_position = next_position.global_position - Vector2(50, 0)
@onready var food_bag = $Bag
@onready var coin_sfx := $Camera/CoinSFX
@onready var money_label = $GUI/Control/MoneyLabel
@onready var sanity_bar := $GUI/Control/SanityBar
@onready var flash_timer := $FlashTimer
@onready var flash := $GUI/Control/Flash

var customer_has_arrived := false
var money_stat := 0
var money = money_stat
var order_completed := false
#endregion


#region Customer, Money and Distortion

func _ready() -> void:
	
	move_customer()


func _process(delta: float) -> void:
	
	if money_stat < money:
		
		money_stat += 1
		money_label.text = str(money_stat)
	
	if money_stat >= 50:
		
		get_tree().change_scene_to_file("res://Scenes/Win.tscn")
	
	if not is_instance_valid(customer):
		
		customer_has_arrived = false
		customer = preload("res://Scenes/Customer.tscn").instantiate()
		add_child(customer)
		customer.global_position = customer_spawn
		customer.order_sprite.position.x += 5
		move_customer()
	
	# Check if order is completed
	if not order_completed and (len(food_bag.ingredients) == len(customer.order)):
		
		order_completed = true
		
		for ingredient in food_bag.ingredients:
			
			if ingredient in customer.order:
				
				money += randi_range(2, 4)
				
				coin_sfx.play()
	
		
		next_position.global_position = next_positions_next_position
		move_customer()

	# Check if customer has reached the exit
	if order_completed and customer.global_position.distance_to(next_position.global_position) < 1.0:
		
		customer.queue_free()
		next_position.global_position = next_positions_original_position
		food_bag.ingredients = []

		order_completed = false
		
		return

	# Customer arrives and starts talking
	if not customer_has_arrived:
		
		if customer.global_position.distance_to(next_position.global_position) < 1.0:
			
			customer_has_arrived = true
			customer.start_talking()
	
	# Sanity
	if sanity_bar.value <= 10:
		
		var distortables = get_tree().get_nodes_in_group("Distortable")
		if sanity_bar.value <= 0:
			
			for distortable in distortables:
				 
				distortable.play("distorted_0")
		
		else:
			
			for distortable in distortables:
				
				distortable.play("distorted_10")
	
	if sanity_bar.value == 10 or sanity_bar.value == 1:
		
		flash.visible = true
		
		if flash_timer.is_stopped():
			
			flash_timer.start()


func _on_flash_timer_timeout():
	
	flash.visible = false


func move_customer() -> void:
	
	var tween = create_tween()
	
	tween.tween_property(
		customer,
		"global_position",
		next_position.global_position,
		2.0
	)
#endregion
