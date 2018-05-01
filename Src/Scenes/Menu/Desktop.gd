extends Control

func _ready():
	$Windows/MenuBox.set_anchors_preset(Control.PRESET_CENTER)
	$Windows/OptionBox.set_anchors_preset(Control.PRESET_CENTER)
	$TaskBar.no_attention($TaskBar/MainIcon)
	$TaskBar/MainIcon.connect("button_up", self, "icon_click", [$Windows/MenuBox])
	$TaskBar/OptionIcon.connect("button_up", self, "icon_click", [$Windows/OptionBox])
	for c in $Windows.get_children():
		$Windows.remove_child(c)

func icon_click(win):
	if $Windows.get_children().has(win):
		$Windows.remove_child(win)
	$Windows.add_child(win)