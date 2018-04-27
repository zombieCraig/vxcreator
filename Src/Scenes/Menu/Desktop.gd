extends Control

func _ready():
	$MenuPosition.set_anchors_preset(Control.PRESET_CENTER)
	$TaskBar.no_attention($TaskBar/MainIcon)
	$TaskBar/MainIcon.connect("button_up", self, "icon_click", [$MenuPosition, $MenuPosition/MenuBox])

func icon_click(box, item):
	box.visible = !box.visible
	item.visible = !item.visible
