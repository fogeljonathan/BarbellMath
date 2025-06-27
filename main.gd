extends Control


func _on_ready() -> void:
	pass

func calculate_plates(weight, barweight):
	var counts = {
		"55":0,
		"45":0,
		"35":0,
		"25":0,
		"10":0,
		"5":0,
		"2.5":0
	}
	weight = roundi(weight/5)*5
	weight -= barweight
	while weight > 0:
		if weight >= 55*2:
			weight -= 55*2
			counts["55"] += 1
		elif weight >= 45*2:
			weight -= 45*2
			counts["45"] += 1
		elif weight >= 35*2:
			weight -= 35*2
			counts["35"] += 1
		elif weight >= 25*2:
			weight -= 25*2
			counts["25"] += 1
		elif weight >= 10*2:
			weight -= 10*2
			counts["10"] += 1
		elif weight >= 5*2:
			weight -= 5*2
			counts["5"] += 1
		elif weight >= 2.5*2:
			weight -= 2.5*2
			counts["2.5"] += 1
		else:
			print("AHHHHH")
	return counts

func add_plate(color, weight):
	var spot = VBoxContainer.new()
	var plate = ColorRect.new()
	plate.color = color
	plate.custom_minimum_size.x = %barbellcollar.size.x * 1.5
	var sizediff = 1.0
	if weight < 25:
		plate.custom_minimum_size.x = %barbellcollar.size.x
		match weight:
			10:
				sizediff = .3
				
			5: 
				sizediff = .4
			2.5: 
				sizediff = .48
				
	
	
	plate.size_flags_vertical = Control.SIZE_EXPAND_FILL
	
	if weight < 25:
		var topfill = Container.new()
		topfill.size_flags_vertical = Control.SIZE_EXPAND_FILL
		topfill.size_flags_stretch_ratio = sizediff
		spot.add_child(topfill)
	
	var tbox = Label.new()
	tbox.text = str(weight)
	tbox.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	tbox.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	tbox.set_anchors_preset(PRESET_FULL_RECT)
	tbox.label_settings = LabelSettings.new()
	tbox.label_settings.font_color = Color.BLACK
	
	plate.add_child(tbox)
	spot.add_child(plate)
	
	if weight < 25:
		var bottomfill = Container.new()
		bottomfill.size_flags_vertical = Control.SIZE_EXPAND_FILL
		bottomfill.size_flags_stretch_ratio = sizediff
		spot.add_child(bottomfill)
	
	%weighthbox.add_child(spot)

func _on_lbinput_value_changed(value: float) -> void:
	var children = %weighthbox.get_children()
	for child in children:
		child.queue_free()
		
	var platecounts = calculate_plates(value, 45)
	for r in platecounts["55"]:
		add_plate(Color.DARK_RED, 55)
	for r in platecounts["45"]:
		add_plate(Color.DODGER_BLUE, 45)
	for r in platecounts["35"]:
		add_plate(Color.YELLOW, 35)
	for r in platecounts["25"]:
		add_plate(Color.LIME_GREEN, 25)
	for r in platecounts["10"]:
		add_plate(Color.WHITE, 10)
	for r in platecounts["5"]:
		add_plate(Color.DODGER_BLUE, 5)
	for r in platecounts["2.5"]:
		add_plate(Color.LIME_GREEN, 2.5)
	

func _on_lbslineedit_text_changed(new_text: String) -> void:
	var weight = string_to_weight(new_text)
	$VBoxContainer/hbox1/lbslineedit.text = str(weight)
	
	var children = %weighthbox.get_children()
	for child in children:
		child.queue_free()
	var platecounts = calculate_plates(weight, 45)
	for r in platecounts["55"]:
		add_plate(Color.DARK_RED, 55)
	for r in platecounts["45"]:
		add_plate(Color.DODGER_BLUE, 45)
	for r in platecounts["35"]:
		add_plate(Color.YELLOW, 35)
	for r in platecounts["25"]:
		add_plate(Color.LIME_GREEN, 25)
	for r in platecounts["10"]:
		add_plate(Color.WHITE, 10)
	for r in platecounts["5"]:
		add_plate(Color.DODGER_BLUE, 5)
	for r in platecounts["2.5"]:
		add_plate(Color.LIME_GREEN, 2.5)

func string_to_weight(s:String):
	if '-' in s:
		return 45
		
	var justnums:String = ""
	for c in s:
		if c in ['0','1','2','3','4','5','6','7','8','9','-']:
			justnums = justnums + c
	var weight = clamp(snapped(int(justnums), 5), 45, 955)
	return weight

func _on_lbslineedit_text_submitted(new_text: String) -> void:
	var weight = string_to_weight(new_text)
	$VBoxContainer/hbox1/lbslineedit.text = str(weight)

func _on_minus_110_pressed() -> void:
	var w = string_to_weight($VBoxContainer/hbox1/lbslineedit.text) - 110
	_on_lbslineedit_text_changed(str(w))

func _on_minus_90_pressed() -> void:
	var w = string_to_weight($VBoxContainer/hbox1/lbslineedit.text) - 90
	_on_lbslineedit_text_changed(str(w))

func _on_minus_70_pressed() -> void:
	var w = string_to_weight($VBoxContainer/hbox1/lbslineedit.text) - 70
	_on_lbslineedit_text_changed(str(w))


func _on_minus_50_pressed() -> void:
	var w = string_to_weight($VBoxContainer/hbox1/lbslineedit.text) - 50
	_on_lbslineedit_text_changed(str(w))


func _on_minus_20_pressed() -> void:
	var w = string_to_weight($VBoxContainer/hbox1/lbslineedit.text) - 20
	_on_lbslineedit_text_changed(str(w))


func _on_minus_10_pressed() -> void:
	var w = string_to_weight($VBoxContainer/hbox1/lbslineedit.text) - 10
	_on_lbslineedit_text_changed(str(w))


func _on_minus_5_pressed() -> void:
	var w = string_to_weight($VBoxContainer/hbox1/lbslineedit.text) - 5
	_on_lbslineedit_text_changed(str(w))


func _on_plus_5_pressed() -> void:
	var w = string_to_weight($VBoxContainer/hbox1/lbslineedit.text) + 5
	_on_lbslineedit_text_changed(str(w))


func _on_plus_10_pressed() -> void:
	var w = string_to_weight($VBoxContainer/hbox1/lbslineedit.text) + 10
	_on_lbslineedit_text_changed(str(w))

func _on_plus_20_pressed() -> void:
	var w = string_to_weight($VBoxContainer/hbox1/lbslineedit.text) + 20
	_on_lbslineedit_text_changed(str(w))


func _on_plus_50_pressed() -> void:
	var w = string_to_weight($VBoxContainer/hbox1/lbslineedit.text) + 50
	_on_lbslineedit_text_changed(str(w))


func _on_plus_70_pressed() -> void:
	var w = string_to_weight($VBoxContainer/hbox1/lbslineedit.text) + 70
	_on_lbslineedit_text_changed(str(w))


func _on_plus_90_pressed() -> void:
	var w = string_to_weight($VBoxContainer/hbox1/lbslineedit.text) + 90
	_on_lbslineedit_text_changed(str(w))


func _on_plus_110_pressed() -> void:
	var w = string_to_weight($VBoxContainer/hbox1/lbslineedit.text) + 110
	_on_lbslineedit_text_changed(str(w))
