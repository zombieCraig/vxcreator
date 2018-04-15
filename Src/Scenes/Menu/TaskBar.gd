extends Control

enum state { ENTERED, EXITED }
var last_state = EXITED
func _process(delta):
	var h = get_viewport().get_visible_rect().size.y
	var y = get_viewport().get_mouse_position().y
	if h - y <= 81:
		if last_state == EXITED:
			$DownTimer.stop()
			$UpTimer.start()
			last_state = ENTERED
	else:
		if last_state == ENTERED:
			$UpTimer.stop()
			$DownTimer.start()
			last_state = EXITED

var slide_v = 0
func slide(dir):
	slide_v = dir * 900
	set_physics_process(true)

func _physics_process(delta):
	margin_top += slide_v * delta
	margin_bottom += slide_v * delta
	if slide_v < 0 and (margin_top <= -81 or margin_bottom <= 0):
		margin_top = -81; margin_bottom = 0
		slide_v = 0
		set_physics_process(false)
	elif slide_v > 0 and (margin_top >= 0 or margin_bottom >= 81):
		margin_top = 0; margin_bottom = 81
		slide_v = 0
		set_physics_process(false)

func _ready():
	set_physics_process(false)
	$UpTimer.connect("timeout", self, "slide", [-1])
	$DownTimer.connect("timeout", self, "slide", [1])