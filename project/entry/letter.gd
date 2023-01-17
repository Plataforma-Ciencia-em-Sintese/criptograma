extends Panel


#  [DOCSTRING]


#  [SIGNALS]
#signal symbol_change
signal selected

#  [ENUMS]

#  [CONSTANTS]


#  [EXPORTED_VARIABLES]

#  [PUBLIC_VARIABLES]


#  [PRIVATE_VARIABLES]

#  [ONREADY_VARIABLES]
onready var Raiz : Control = find_parent("Raiz")
onready var pic : Label = $letter/pic
onready var letter : Button = $letter/letter

#  [OPTIONAL_BUILT-IN_VIRTUAL_METHOD]
#func _init() -> void:
#	passletter/


#  [BUILT-IN_VIRTUAL_METHOD]
func _ready():
	_update_theme()


#  [REMAINIG_BUILT-IN_VIRTUAL_METHODS]
#func _process(_delta: float) -> void:
#	pass


#  [PUBLIC_METHODS]




#  [PRIVATE_METHODS]

func _update_theme() -> void:
	# Background Panel
	var panel : StyleBoxFlat = self.get("custom_styles/panel")
#	panel.bg_color = API.theme.get_color(API.theme.PL2)
#	panel.border_color = API.theme.get_color(API.theme.PB)
	panel.border_color = API.theme.get_color(API.theme.PD1)
	
	# Label theme
	
	# Button Theme
	var hover : StyleBoxFlat = letter.get("custom_styles/hover")
	var press : StyleBoxFlat = letter.get("custom_styles/pressed")
	var focus : StyleBoxFlat = letter.get("custom_styles/focus")
	var disab : StyleBoxFlat = letter.get("custom_styles/disabled")
	var norma : StyleBoxFlat = letter.get("custom_styles/normal")
	
	hover.bg_color = API.theme.get_color(API.theme.PL2)
	press.bg_color = API.theme.get_color(API.theme.PL2)
	focus.bg_color = API.theme.get_color(API.theme.PL2)
	disab.bg_color = API.theme.get_color(API.theme.PD2)
	norma.bg_color = API.theme.get_color(API.theme.PB)

func _selected() -> void:
	Raiz.set_selected_symbol(pic.text)

#  [SIGNAL_METHODS]


func _on_letter_pressed():
	var p = pic.text
	printt(len(Raiz.SYMBOL_LIST), Raiz.SYMBOL_LIST.find(p))
	emit_signal("selected")
	_selected()

func _on_solution_changed():
	letter.text = Raiz.get_new_solution(pic.text)
