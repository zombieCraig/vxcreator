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

func _process(delta):
	var port = get_viewport()
	var h = port.get_visible_rect().size.y
	var y = port.get_mouse_position().y
	
	if h - y <= 81:
		timer += delta
	else:
		timer = 0
		$Icons.position.y = 81
	if timer >= 1:
		timer = 1
		$Icons.position.y = 0
