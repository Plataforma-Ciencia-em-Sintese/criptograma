extends Panel


#  [DOCSTRING]


#  [SIGNALS]
#  [ENUMS]

#  [CONSTANTS]


#  [EXPORTED_VARIABLES]

#  [PUBLIC_VARIABLES]


#  [PRIVATE_VARIABLES]

#  [ONREADY_VARIABLES]
onready var Raiz : Control = find_parent("Raiz")
onready var box : HBoxContainer = $Entry
onready var tip : RichTextLabel = $Entry/Tip

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
#	print(API.theme.get_color(API.theme.PD1))
	var panel : StyleBoxFlat = self.get("custom_styles/panel")
	panel.bg_color = API.theme.get_color(API.theme.PL2)
#	panel.border_color = API.theme.get_color(API.theme.PB)
	panel.border_color = API.theme.get_color(API.theme.PD1)
	
	tip.set("custom_colors/default_color", API.theme.get_color(API.theme.PD3))

#  [SIGNAL_METHODS]
