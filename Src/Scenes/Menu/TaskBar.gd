extends Control

func show():
	pass

func hide():
	$Icons.position.y += rect_size.y
	connect("mouse_entered", self, "start_hover")

func start_hover():
	print('entered')

func _ready():
	pass
