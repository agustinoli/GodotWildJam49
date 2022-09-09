extends VBoxContainer


func _ready()->void:
	MenuEvent.connect("Game", self, "on_show_game")
	MenuEvent.Game = false
	
	#Localization
	SettingsLanguage.connect("ReTranslate", self, "retranslate")
	retranslate()


func _on_Back_pressed()->void:
	MenuEvent.Game = false

#EVENT SIGNALS
func on_show_game(value:bool)->void:
	visible = value
	if visible:
		get_tree().get_nodes_in_group("Game")[0].grab_focus()

#Localization
func retranslate()->void:
	find_node("GameLabel").text = tr("GAME")
	find_node("Back").text = tr("BACK")
	find_node("DifficultyLabel").text = tr("DIFFICULTY")
	find_node("Blood").text = tr("BLOOD")
	find_node("Pacific").text = tr("PACIFIC")
	
	var dif_select = find_node("DifficultySelect")
	dif_select.clear()
	dif_select.add_item(tr("HARD"))
	dif_select.add_item(tr("NORMAL"))
	dif_select.add_item(tr("EASY"))



func _on_DifficultySelect_item_selected(index):
	Game.difficulty = index


func _on_Blood_toggled(button_pressed):
	Game.gore_enabled = button_pressed


func _on_Pacific_toggled(button_pressed):
	Game.pacific_mode = button_pressed
