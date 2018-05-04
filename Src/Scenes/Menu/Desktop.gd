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
	moves[win]['dx'] *= -1
	moves[win]['dy'] *= -1
	moves[win]['state'] = MAXIMIZE

func minimize(win):
	if moves.has(win):
		maximize(win)
		moves[win]['state'] = MINIMIZE
		return
	moves[win] = { 'xy': win.rect_position,
				   'size': win.rect_size,
				   'dx': win.rect_position.x,
				   'dy': win.rect_position.y - rect_size.y,
				   'state': 0 }

func _process(delta):
	for win in moves.keys():
		if moves[win]['state'] == HIDDEN:
			continue
		if moves[win]['state'] == MAXIMIZE:
			if win.rect_position.y <= moves[win]['xy'].y:
				win.rect_position = moves[win]['xy']
				win.rect_size = moves[win]['size'].abs()
				moves.erase(win)
				continue
		if moves[win]['state'] == MINIMIZE:
			if win.rect_position.y >= rect_size.y:
				win.hide()
				moves[win]['state'] = HIDDEN
		var scale = 5 * delta
		win.rect_position.x -= moves[win]['dx'] * scale
		win.rect_position.y -= moves[win]['dy'] * scale
		win.rect_size.y -= moves[win]['size'].y * scale
		win.rect_size.x -= moves[win]['size'].x * scale