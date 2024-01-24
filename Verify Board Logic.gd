extends Node





func _on_click_info_click_stopped():
	if PublicData.draggedBingoBoard == null: return
	var draggedBingoBoard = PublicData.draggedBingoBoard
	if $"../MouseInArea".mouseInRect:
		for button in draggedBingoBoard.get_board_full_line():
			if button.text in PublicData.numberCallHistory:
				button.modulate = Color.GREEN
			else:
				button.modulate = Color.RED
			await get_tree().create_timer(.2).timeout
		
		await get_tree().create_timer(.5).timeout
		
		if draggedBingoBoard.is_full_line_nums_in_num_history():
			$"../../../Label".text = str(int($"../../../Label".text)+1)
			var newBoard = QuickScene.create_scene_node("res://BingoBoard.tscn")
			$"../../../Bingo Hand".add_child(newBoard)
			newBoard.global_position = ControlGlobalTransform.new(draggedBingoBoard).position
			newBoard.rotation = ControlGlobalTransform.new(draggedBingoBoard).rotation
			for i in 100:
				await get_tree().physics_frame
				draggedBingoBoard.position.x += FakeDelta.delta * 2000
			draggedBingoBoard.queue_free()
			return
		
		
		
		for button in PublicData.draggedBingoBoard.get_board_full_line():
			if button.text in PublicData.numberCallHistory:
				button.modulate = Color.WHITE
			else:
				button.modulate = Color.WHITE
			await get_tree().create_timer(.2).timeout
		
