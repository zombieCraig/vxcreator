extends Node2D

var offset = 81 # height of taskbar
func relocate():
	var winsz = get_viewport().get_visible_rect().size
	self.position.y = winsz.y - offset

func show():
	offset = 81; relocate()

func hide():
	offset = 0; relocate()

func _ready():
	get_viewport().connect("size_changed", self, "relocate")
	show()
