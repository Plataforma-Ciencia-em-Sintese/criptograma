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
	pass

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
