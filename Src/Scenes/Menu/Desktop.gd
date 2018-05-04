extends Control

func _ready():
	$Windows/MenuBox.set_anchors_preset(Control.PRESET_CENTER)
	$Windows/OptionBox.set_anchors_preset(Control.PRESET_CENTER)
	$TaskBar/MainIcon.connect("button_up", self, "icon_click", [$Windows/MenuBox])
	for c in $Windows.get_children():
		$Windows.remove_child(c)
		$Hidden.add_child(c)

func hide_window(win):
	if $Windows.get_children().has(win):
		$Windows.remove_child(win)
		$Hidden.add_child(win)

func icon_click(win):
	if $Windows.get_children().has(win):
		$Windows.remove_child(win)
	else:
		$Hidden.remove_child(win)
	$Windows.add_child(win)