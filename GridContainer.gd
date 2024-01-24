@tool
class_name BingoGrid extends GridContainer

@export var referenceButton:Button
@export var buttonsOnX:int = 0 : 
	set(value): buttonsOnX = min(10,value) ; update_button_count()
@export var buttonsOnY:int = 0 : 
	set(value): buttonsOnY = min(10,value) ; update_button_count()

@export var randomizeButtons:bool = true:
	set(value):
		randomizeButtons = value
		await number_buttons()
		if randomizeButtons : await randomize_buttons()
		if centerIsFree: await make_center_wild()

@export var randRangeMult:int = 1:
	set(value):
		randRangeMult = value
		await number_buttons()
		if randomizeButtons : await randomize_buttons()
		if centerIsFree: await make_center_wild()
		

@export var centerIsFree:bool:
	set(value):
		centerIsFree = value
		await number_buttons()
		if randomizeButtons : await randomize_buttons()
		if centerIsFree: await make_center_wild()

func _ready():
	update_button_count()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	size = Vector2.ZERO
	if get_parent() != null:
		get_parent().size = Vector2.ZERO
		get_parent().scale.x = get_parent().scale.y * 1.16806722689 

func update_button_count():
	
	for i in abs(get_child_count() - (buttonsOnX * buttonsOnY)):
		if get_child_count() > buttonsOnX * buttonsOnY:
			get_child(-i).queue_free()
		else:
			if referenceButton != null:
				await add_child(referenceButton.duplicate())
	
	#if FakeDelta.delta != 1:
	#	await get_tree().physics_frame
	#	await get_tree().physics_frame
	
	columns = buttonsOnX
	
	await number_buttons()
	if randomizeButtons : await randomize_buttons()
	if centerIsFree: await make_center_wild()
	
	size = Vector2.ZERO
	if get_parent() != null:
		get_parent().size = Vector2.ZERO
		get_parent().scale.x = get_parent().scale.y * 1.16806722689 

func number_buttons():
	
	var numbers = []
	for column in columns:
		var row = range(1+(15*column),15*(column+1))
		row.shuffle()
		if column == 0: # Gaurentes the first row looks correct
			while not row.slice(-5).any(func(a:int): return a >= 10):
				row.pop_back()
		numbers.append_array(row.slice(-5))
	
	for child in get_child_count():
		get_child(child).modulate = Color.WHITE
		get_child(child).button_pressed = false
		get_child(child).text = str(numbers[int(child%5*5 + child/5)])
func randomize_buttons():
	for child in get_children().duplicate():
		await move_child(child,randi_range(0,get_child_count()))

func make_center_wild():
	if get_child_count() > int(buttonsOnX * buttonsOnY * .5):
		get_child(int(buttonsOnX * buttonsOnY * .5)).text = ""
