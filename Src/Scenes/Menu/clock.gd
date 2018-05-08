extends Control

var DEBUG = false

const MODE_CLOCK = 0
const MODE_TIMER = 1
const MODE_TIME_STOP = 2

const TIME_UPDATE_INTERVAL = 0.1

var TimeMode = MODE_CLOCK
var TimerStarted = {}
var TimerStoppedAt = {}
var TimeElapsed = 0.0 # Used only for graphic updating
var IndicatorTime = preload("res://Images/Menu/clock_indicator_time.png")
var IndicatorTimer = preload("res://Images/Menu/clock_indicator_timer.png")

func timeDelta(now, before):
	var diff={"minute": 0, "second": 0}
	var seconds_before = before["hour"] * 60 * 60 + before["minute"] * 60 + before["second"]
	var seconds_now = now["hour"] * 60 * 60 + now["minute"] * 60 + now["second"]
	seconds_now -= seconds_before
	diff["minute"] = seconds_now / 60
	diff["second"] = seconds_now - (diff["minute"] * 60)
	return(diff)

func activateTimer():
	TimeMode = MODE_TIMER
	get_node("Type").add_color_override("font_color", Color(0.156, 0.525, 0.286, 1))
	get_node("Type").set_text("Lifespan")
	get_node("Indicator").set_texture(IndicatorTimer)
	TimerStarted = OS.get_time()

func stopTimer():
	TimeMode = MODE_TIME_STOP
	TimerStoppedAt = OS.get_time()

func activateClock():
	TimeMode = MODE_CLOCK
	get_node("Type").add_color_override("font_color", Color(0, 0.6, 0.56, 1))
	get_node("Type").set_text("Time")
	get_node("Indicator").set_texture(IndicatorTime)

func toggleMode():
	if TimeMode == MODE_CLOCK:
		activateTimer()
	else:
		activateClock()

func updateTime():
	var time = OS.get_time()
	var minute = str(time["minute"])
	if time["minute"] < 10:
		minute = "0" + minute
	get_node("Timer").set_text(str(time["hour"]) + ":" + minute)

func updateTimer():
	var now = OS.get_time()
	var diff = timeDelta(now, TimerStarted)
	var seconds = "00"
	if diff["second"] < 10:
		seconds = "0" + str(diff["second"])
	else:
		seconds = str(diff["second"])
	get_node("Timer").set_text(str(diff["minute"]) + ":" + seconds)

func _input(event):
	if DEBUG:
		if event.is_pressed():
			toggleMode()

func _process(delta):
	if not TimeMode == MODE_TIME_STOP:
		TimeElapsed += delta
		if TimeElapsed > TIME_UPDATE_INTERVAL:
			if TimeMode == MODE_CLOCK:
				updateTime()
			else:
				updateTimer()
			TimeElapsed = 0.0

func _ready():
	activateClock()
	if DEBUG:
		set_process_input(true)
	set_process(true)


