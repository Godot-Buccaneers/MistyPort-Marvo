extends Node


var draggedBingoBoard:BingoBoard = null

var numberCallHistory = []:
	set(value):
		numberCallHistory = value
		number_call_updated.emit()

signal number_call_updated
