extends BingoBoard

var missChance = .05
var callbackMemoryLength = 5

func _ready():
	PublicData.number_call_updated.connect(_on_number_call_updated)
	#super()
	

func _on_number_call_updated():
	for num in $ColorRect/SplitContainer/GridContainer.get_children():
		var numID = $ColorRect/SplitContainer/GridContainer.get_children().find(num)
		
		
		if num.text in PublicData.numberCallHistory.slice(-callbackMemoryLength)+[""]:
			if randf() < missChance : numID += randi_range(-1,1)
			if $ColorRect/SplitContainer/GridContainer.get_child_count() > numID:
				$ColorRect/SplitContainer/GridContainer.get_child(numID).button_pressed = true
			else:
				num.button_pressed = true
	
	if check_board_for_full_line():
		for button in get_board_full_line():
			button.modulate = Color.WHITE
		
		for i in 1 / FakeDelta.delta:
			position.y = lerp(0.0,$"../Control".position.y,i*FakeDelta.delta)
			await get_tree().physics_frame
		
		for button in get_board_full_line():
			if button.text in PublicData.numberCallHistory:
				button.modulate = Color.GREEN
			else:
				button.modulate = Color.RED
				button.button_pressed = false
			await get_tree().create_timer(.2).timeout
		
		await get_tree().create_timer(.5).timeout
		
		if is_full_line_nums_in_num_history():
			$"../../Label".text = str(int($"../../Label".text)-1)
			$ColorRect/SplitContainer/GridContainer.randomizeButtons = $ColorRect/SplitContainer/GridContainer.randomizeButtons
		for i in 1 / FakeDelta.delta:
			position.y = lerp($"../Control".position.y,0.0,i*FakeDelta.delta)
			await get_tree().physics_frame
		
