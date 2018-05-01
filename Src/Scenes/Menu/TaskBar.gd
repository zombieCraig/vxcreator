extends Control

func _ready():
	set_physics_process(false)
	$UpTimer.connect("timeout", self, "start_slide", [-1])
	$DownTimer.connect("timeout", self, "start_slide", [1])

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

var notify = false
onready var icons = {$MainIcon: false, $OptionIcon: false}
var vs = [-2, -5, -8]
var bounces = 2; var v = vs[bounces]; var a = 0.5; var t = 0
func bounce(delta):
	t += delta
	while t >= 0.02:
		v += a; t -= 0.02
		step()
func step():
	for icon in icons.keys():
		if not icons[icon]:
			continue
		var p = icon.get_position()
		p.y += v
		if p.y < 0: # in the "air"
			icon.set_position(p)
			return
		p.y = 0
		icon.set_position(p)
		bounces -= 1
		if bounces < 0:
			bounces = 2
		v = vs[bounces]; t = 0

var slide_v = 0
func start_slide(dir):
	slide_v = dir * 900
	set_physics_process(true)
func slide(delta):
	margin_top += slide_v * delta
	margin_bottom += slide_v * delta
	if slide_v < 0 and (margin_top <= -81 or margin_bottom <= 0):
		margin_top = -81; margin_bottom = 0
		slide_v = 0
		set_physics_process(notify)
	elif slide_v > 0 and (margin_top >= 0 or margin_bottom >= 81):
		margin_top = 0; margin_bottom = 81
		slide_v = 0
		set_physics_process(notify)

func _physics_process(delta):
	if slide_v != 0:
		slide(delta)
	if notify:
		bounce(delta)

# "public" methods
func get_attention(icon):
	icons[icon] = true
	if not notify:
		notify = true
		set_physics_process(true)
func no_attention(icon):
	icons[icon] = false
	for b in icons.values():
		if b:
			return
	notify = false
	set_physics_process(false)

func show(): # always visible
	set_process(false)
	start_slide(-1)
func hide(): # NOTE: initalizes to hidden
	set_process(true)
	start_slide(1)
