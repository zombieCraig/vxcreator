extends Control

func _ready():
	$MenuPosition.set_anchors_preset(Control.PRESET_CENTER)
	$TaskBar.no_attention($TaskBar/MainIcon)
	$TaskBar/MainIcon.connect("button_up", self, "icon_click", [$MenuPosition/MenuBox])

func icon_click(item):
	item.visible = !item.visible
