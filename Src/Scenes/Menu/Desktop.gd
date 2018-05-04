extends Control

func _ready():
	$Windows/MenuBox.set_anchors_preset(Control.PRESET_CENTER)
	$Windows/OptionBox.set_anchors_preset(Control.PRESET_CENTER)
	$TaskBar/MainIcon.connect("button_up", self, "maximize", [$Windows/MenuBox])
	for win in $Windows.get_children():
		win.hide()
		minimize(win)

enum { MINIMIZE, MAXIMIZE, HIDDEN }
var moves = {}
func maximize(win):
	# raise above all other windows
	$Windows.remove_child(win)
	$Windows.add_child(win)
	win.show()
	if not moves.has(win) or moves[win]['state'] == MAXIMIZE:
		return
	moves[win]['size'].x *= -1
	moves[win]['size'].y *= -1
	moves[win]['state'] = MAXIMIZE

func minimize(win):
	if moves.has(win):
		maximize(win)
		moves[win]['state'] = MINIMIZE
		return
	moves[win] = { 'size': win.rect_size, 'state': 0 }

func transition(delta):
	for win in moves.keys():
		if moves[win]['state'] == HIDDEN:
			continue
		if moves[win]['state'] == MAXIMIZE:
			if win.rect_size.y >= moves[win]['size'].abs().y:
				win.rect_size = moves[win]['size'].abs()
				moves.erase(win)
				continue
		if moves[win]['state'] == MINIMIZE:
			if win.rect_size.y <= 0:
				win.hide()
				moves[win]['state'] = HIDDEN
		var scale = 5 * delta
		win.rect_size.y -= moves[win]['size'].y * scale
		win.rect_size.x -= moves[win]['size'].x * scale

var a = -0.005
var v = 0
func pulse(delta):
	if $TaskbarGlow.modulate.a <= 0.35:
		v = 0.5
	v += a
	$TaskbarGlow.modulate.a += v * delta

func _process(delta):
	transition(delta)
	pulse(delta)