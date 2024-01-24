class_name BingoNumbersButton extends Button

var numberHistory = [""]


func _ready():
	numberHistory = get_parent().get_child(get_parent().get_children().find(self)-1).numberHistory
	
	text = ""
	
	while text in numberHistory and numberHistory.size() < 24 * 3:
		text = str(int(randi_range(1,25)) * 3 - randi_range(0,3-1))
	
	if not text in numberHistory:
		numberHistory.append(text)
	PublicData.numberCallHistory = numberHistory
	
	if text != "":
		text = ["M-","A-","R-","V-","O-",][(int(text)-1)/15] + text
	
	if not  numberHistory.size() < 24 * 3:
		text = ""
	
	
	
	await get_tree().create_timer(7).timeout
	
	_on_pressed()

func _on_pressed():
	if not disabled:
		get_parent().add_child(duplicate())
		disabled = true
		for child in get_parent().get_children():
			child.position.x -= 178
			if child == self: return
