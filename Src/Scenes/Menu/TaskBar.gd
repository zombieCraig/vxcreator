extends Node2D

func clicked(btn):
	btn.setup()
	btn.set_physics_process(true)

func _ready():
	$MainBtn.connect("pressed", self, "clicked", [$MainBtn])
	pass
