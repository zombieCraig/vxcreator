extends Control

var timer = 0
func hide():
	$Icons.position.y = 81
	timer = 0
	set_process(true)

func show():
	$Icons.position.y = 0
	set_process(false)

func _ready():
	hide()

var dir = 0
func _process(delta):
	var port = get_viewport()
	if port.get_visible_rect().size.y - port.get_mouse_position().y <= 81:
		timer += delta
	else:
		timer = 0; dir = 1000;
	if timer >= 1:
		timer = 1; dir = -1000
	if dir == 0:
		return
	if dir < 0 and $Icons.position.y <= 0:
		dir = 0; return
	if dir > 0 and $Icons.position.y >= 81:
		dir = 0; return
	$Icons.position.y += dir * delta