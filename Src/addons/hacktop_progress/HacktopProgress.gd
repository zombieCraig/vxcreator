tool
extends Node2D

export(float, 0.0, 1.0, 0.01) var progress = 0.0 setget set_val
export(bool) var animate = true
const MAX_POINTS = 24
const MAX_BLADES = 3
var Anim_inc_rate = 0.5
var last_val = 0
var goal_val = 0
var ttime = 0

func set_animation_rate(val):
	Anim_inc_rate = val

func get_animation_rate():
	return Anim_inc_rate

func set_animation(val):
	animate = val

func get_animation():
	return animate

# Updates the UI progress to a set %val
func update_progress(val):
	var point_progress = MAX_POINTS * val
	for point in get_node("Points").get_children():
		var p = int(point.get_name())
		if point_progress > p:
			point.show()
			point.modulate.a = 1
#			point.set("modulate", Color(255, 255, 255, 255))
#			point.set_opacity(1)
		elif point_progress + 1 > p:
			point.show()
			point.modulate.a = point_progress + 1 - p
#			point.set("modulate", Color(255, 255, 255, point_progress + 1 - p))
#			point.set_opacity(point_progress + 1 - p)
		else:
			point.hide()
	# Update Blades
	var blade_progress = MAX_BLADES * val
	for blade in get_node("Blades").get_children():
		var b = int(blade.get_name())
		if blade_progress > b:
			blade.show()
			blade.modulate.a = 1
#			blade.set("modulate", Color(0, 0, 0, 255))
#			blade.set_opacity(1)
		elif blade_progress + 1 > b:
			blade.show()
			blade.modulate.a = blade_progress + 1 - b
#			blade.set("modulate", Color(0, 0, 0, blade_progress + 1 - b))
#			blade.set_opacity(blade_progress + 1 - b)
		else:
			blade.hide()


func get_val():
	return progress

func set_val(val):
	if animate:
		last_val = get_val()
		goal_val = val
	else:
		progress = val
		update_progress(val)

func clear_all():
	for point in get_node("Points").get_children():
		point.hide()
	for blade in get_node("Blades").get_children():
		blade.hide()
	set_val(0)

func _process(delta):
	if not animate:
		return
	if goal_val == progress:
		return
	if progress < goal_val:
		progress += Anim_inc_rate * delta
		if progress > goal_val:
			progress = goal_val
	elif progress > goal_val:
		progress -= Anim_inc_rate * delta
		if progress < goal_val:
			progress = goal_val
	update_progress(progress)

func _ready():
	if !(Engine.is_editor_hint()):
		clear_all()
	if animate:
		set_process(true)
