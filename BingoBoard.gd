class_name BingoBoard extends Control

@onready var board:BingoGrid = $ColorRect/SplitContainer/GridContainer
var isValid:bool:
	get:
		return check_board_for_full_line()

@export var isDraggable:bool = true

var isDragged:bool :
	set(value):
		isDragged = value and isDraggable
		if isDragged: PublicData.draggedBingoBoard = self


func check_board_for_full_line():
	# Horizontal Checks
	for y in board.buttonsOnY:
		if board.get_children().slice(board.buttonsOnX*y,board.buttonsOnX+(board.buttonsOnX*y)).all(func(a:Button): return a.button_pressed):
			return true
	
	# Vertical Checks
	for x in board.buttonsOnX:
		if board.get_children().slice(x,board.buttonsOnX*board.buttonsOnY,board.buttonsOnX).all(func(a:Button): return a.button_pressed):
			return true
	
	# Diagonal Checks
	if board.get_children().slice(0,board.buttonsOnX*board.buttonsOnY,board.buttonsOnX+1).all(func(a:Button): return a.button_pressed):
		return true
	if board.get_children().slice(board.buttonsOnX-1,(board.buttonsOnX*board.buttonsOnY)-1,board.buttonsOnX-1).all(func(a:Button): return a.button_pressed):
		return true
	
	return false

func get_board_full_line(matchDelay = 0):
	# Horizontal Checks
	for y in board.buttonsOnY:
		if board.get_children().slice(board.buttonsOnX*y,board.buttonsOnX+(board.buttonsOnX*y)).all(func(a:Button): return a.button_pressed):
			if matchDelay != 0 : matchDelay -= 1 
			else: return board.get_children().slice(board.buttonsOnX*y,board.buttonsOnX+(board.buttonsOnX*y))
	
	# Vertical Checks
	for x in board.buttonsOnX:
		if board.get_children().slice(x,board.buttonsOnX*board.buttonsOnY,board.buttonsOnX).all(func(a:Button): return a.button_pressed):
			if matchDelay != 0 : matchDelay -= 1 
			else: return board.get_children().slice(x,board.buttonsOnX*board.buttonsOnY,board.buttonsOnX)
	
	# Diagonal Checks
	if board.get_children().slice(0,board.buttonsOnX*board.buttonsOnY,board.buttonsOnX+1).all(func(a:Button): return a.button_pressed):
		if matchDelay != 0 : matchDelay -= 1 
		else: return board.get_children().slice(0,board.buttonsOnX*board.buttonsOnY,board.buttonsOnX+1)
	if board.get_children().slice(board.buttonsOnX-1,(board.buttonsOnX*board.buttonsOnY)-1,board.buttonsOnX-1).all(func(a:Button): return a.button_pressed):
		if matchDelay != 0 : matchDelay -= 1 
		else: return board.get_children().slice(board.buttonsOnX-1,(board.buttonsOnX*board.buttonsOnY)-1,board.buttonsOnX-1)
	
	return []

func get_full_line_nums(matchDelay = 0):
	var buttons = get_board_full_line(matchDelay)
	var nums = []
	  
	for button in buttons:
		nums.append(button.text)
	return nums

func array_contains_array(array1, array2):
	for item in array2:
		if !array1.has(item):
			return false
	return true

func is_full_line_nums_in_num_history():
	if check_board_for_full_line() == false : return false
	var bingoNum : BingoNumbersButton = %"Bingo Num"
	var matchDelay = 0
	while get_board_full_line(matchDelay) != []:
		if array_contains_array(PublicData.numberCallHistory,get_full_line_nums(matchDelay)):
			return true
		matchDelay += 1

	return false
