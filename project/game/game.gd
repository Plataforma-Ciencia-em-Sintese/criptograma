extends Control


#  [DOCSTRING]


#  [SIGNALS]
signal game_over
signal table_change

#  [ENUMS]

#  [CONSTANTS]
const scene_entry = preload("res://entry/entry.tscn")
const scene_letter = preload("res://entry/letter.tscn")

const ALLOWED_KEYS = [81, 87, 69, 82, 84, 89, 85, 73, 79, 80, 65, 83, 68, 70, 71, 72, 74, 75, 76, 90, 88, 67, 86, 66, 78, 77, 59, 16777220]
const SPECIAL_CHAR_DICIO = {'Á': 'A', 'À': 'A', 'Ã': 'A', 'Â': 'A', 'É': 'E', 'È': 'E', 'Ẽ': 'E', 'Ê': 'E', 'Í': 'I', 'Ì': 'I', 'Ĩ': 'I', 'Î': 'I', 'Ó': 'O', 'Ò': 'O', 'Õ': 'O', 'Ô': 'O', 'Ú': 'U', 'Ù': 'U', 'Ũ': 'U', 'Û': 'U', 'Ç': 'C', 'Ñ': 'N', '': ' ', ' ': ' '}
const SYMBOL_LIST = ['\uf51c', # nf-mdi-airplane
					'\uf51f', # nf-mdi-alarm
					'\uf75c', # nf-mdi-football
					'\uf565', # nf-mdi-attachment
					'\uf290', # nf-fa-shopping_bag
					'\uf51b', # nf-mdi-airballoon
					'\uf575', # nf-mdi-basket
					'\ufd04', # nf-mdi-basketball
					'\uf499', # nf-oct-beaker
					'\uf0fc', # nf-fa-beer
					'\uf206', # nf-fa-bicycle
					'\uf06d', # nf-fa-fire
					'\uf02d', # nf-fa-book
#					'\ueaaf', # nf-cod-bug
					'\uf0eb', # nf-fa-lightbulb_o
					'\uf5e6', # nf-mdi-bus
					'\uf0f4', # nf-fa-coffee
					'\uf1ec', # nf-fa-calculator
#					'\ueb92', # nf-cod-call_incoming
					'\uf030', # nf-fa-camera
					'\uf60a', # nf-mdi-car
					'\uf60f', # nf-mdi-cart
					'\ue22b', # nf-fae-palette_color
					'\uf1b2', # nf-fa-cube
					'\uf68f', # nf-mdi-content_cut
					'\uf219', # nf-fa-diamond
					'\uf759', # nf-mdi-food
					'\uf739', # nf-mdi-fish
					'\uf490', # nf-oct-flame
					'\ue241', # nf-fae-footprint
					'\uf7a0', # nf-mdi-gift
					'\uf7cd', # nf-mdi-headset
					'\ufd28', # nf-mdi-ice_cream
					'\uf80a', # nf-mdi-key_variant
					'\uf829', # nf-mdi-leaf
					'\uf45f', # nf-oct-megaphone
					'\uf75a', # nf-mdi-food_apple
					'\ue30c', # nf-weather-day_sunny_overcast
					'\uf1b0', # nf-fa-paw
#					'\ue684', # nf-seti-prisma
					'\ue239', # nf-fae-raining
					'\uf95f', # nf-mdi-ribbon
					'\uf962', # nf-mdi-rocket
					'\ufb8a', # nf-mdi-skull
					'\ue209', # nf-fae-telescope
					'\ue220', # nf-fae-umbrella
					'\uf091', # nf-fa-trophy
					'\ufa8b', # nf-mdi-water
					]


#  [EXPORTED_VARIABLES]

#  [PUBLIC_VARIABLES]


#  [PRIVATE_VARIABLES]
var _selected: String

#  [ONREADY_VARIABLES]

onready var _table: VBoxContainer = $AspectRatioContainer/Separador/Panel/GameTable
onready var _panel_info: Panel = $PanelInformation
onready var _solution_letters: Dictionary = {}
onready var _solution_mask: Dictionary = {}
onready var _reverse_solution: Dictionary = {}
onready var _user_solution: Dictionary = {}
onready var _game_running: bool = true

#  [OPTIONAL_BUILT-IN_VIRTUAL_METHOD]
#func _init() -> void:
#	pass

func _ready():
	_gen_solution_table()
	_populate_table()
	print(_solution_mask)
#  [BUILT-IN_VIRTUAL_METHOD]

func _unhandled_key_input(event):
#	print(event)
#	if event is InputEventKey:
#		print(event.is_pressed())
		
	if event is InputEventKey and event.is_pressed():
		var event_key = event as InputEventKey
#		var dic_button = _verify_owner(self.get_focus_owner()) as Dictionary
#		_last_selected_button = dic_button
#		if ((event_key.get_physical_scancode() in _allowed_keys) and dic_button.has("button")):
#		if ((event_key.get_physical_scancode() in ALLOWED_KEYS) and dic_button.has("button")):
		if ((event_key.get_physical_scancode() in ALLOWED_KEYS) and _game_running) :
			_user_solution[_selected] = char(event_key.get_scancode())
			_update_user_solution()
			_verify_solution()
#			if not dic_button["button"].disabled:
#				dic_button["value"] = char(event_key.get_scancode())
#				dic_button["button"].text = char(event_key.get_scancode())
#			if (event_key.get_physical_scancode() == 16777220): #Backspace
#				_previous_button(dic_button)
#			else:
#				_next_button(dic_button)
#			_show_selected_word()
#			_verify_solution()
#			_verify_endgame()


#  [REMAINIG_BUILT-IN_VIRTUAL_METHODS]
#func _process(_delta: float) -> void:
#	pass


#  [PUBLIC_METHODS]

func get_new_solution(valor: String) -> String:
	return _user_solution[valor]

func set_selected_symbol(valor: String) -> void:
	_selected = valor

#  [PRIVATE_METHODS]
func _gen_solution_table() -> void:
	seed(ceil(Time.get_unix_time_from_system()))
	var valid : String = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
#	print(len(SYMBOL_LIST))
	var copylist: Array = SYMBOL_LIST.duplicate(true)#.slice(47 - valid.length(), 47)
	for i in valid:
		copylist.shuffle()
		var symbol: String = copylist.pop_front()
#		_solution_letters[symbol] = i
		_solution_letters[i] = symbol
#		_solution_mask[i] = false
		_solution_mask[i] = true
		_user_solution[symbol] = ""

func _populate_table() -> void:
	for i in API.get_game_words():
#		print(i.to_upper())
		var i_entry : Panel = scene_entry.instance()
		var i_box : HBoxContainer = i_entry.get_node("Entry")
#		print(i_entry)
		var i_up : String = i.to_upper()
#		var i_tip : Label = i_entry.get_node("Tip")
		var i_tip : RichTextLabel = i_entry.get_node("Entry/Tip")
#		var i_text: String = API.get_game_words()[i]
#		print(API.get_game_words())
#		print(i_tip)
		i_tip.text = API.get_game_words()[i]["clue"]
#		i_tip.text = i
#		i_tip.text = "i_text"
#		print(API.get_game_words()[i])
		_table.add_child(i_entry)
		for j in i_up:
			var j_letter = scene_letter.instance()
			var j_pic : Label = j_letter.get_node("letter/pic")
			var j_sol : Button = j_letter.get_node("letter/letter")
			var je : String = j
			if je in SPECIAL_CHAR_DICIO:
				je = SPECIAL_CHAR_DICIO[j]
			if je in _solution_letters:
				j_pic.text = _solution_letters[je]
				_solution_mask[je] = false
#				_solution_mask[je] = true
				self.connect("table_change", j_letter, "_on_solution_changed")
			else:
				j_pic.text = " "
				j_sol.disabled = true
			i_box.add_child(j_letter)
			

func _get_actual_symbol() -> void:
	pass

func _update_user_solution () -> void:
	emit_signal("table_change")

func _verify_solution () -> void:
	var win_rule = true
#	printt(_solution_mask, _user_solution)
	for i in _solution_mask: # "i" eh a letra a ser testada
		var mask = _solution_mask[i] # se isso aqui eh verdadeiro, a rodada eh verdadeira
		var simb = _solution_letters[i] # simbolo correto para a letra i
		var comp = i == _user_solution[simb] # verifica se o valor atribuido pelo usuario eh igual a resposta
		win_rule = win_rule and (mask or comp)
#		var round_iteration = true
#		if (_solution_mask[i]):
#			for j in _user_solution:
#				if (i == _user_solution[j]):
#					round_iteration = true
#		else:
#			round_iteration = true
#		win_rule = win_rule and round_iteration
##		printt(i, win_rule)
	if (win_rule):
		print("fim de jogo")
		_panel_info.show()
		_game_running = false
		emit_signal("game_over")

#  [SIGNAL_METHODS]


func _on_home_pressed():
	get_tree().change_scene("res://home/home.tscn")
