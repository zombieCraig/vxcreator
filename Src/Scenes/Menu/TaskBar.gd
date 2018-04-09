extends Node2D

var actor
func clicked(btn):
	actor = btn
	self.set_physics_process(true)

func _ready():
	self.set_physics_process(false)
	$MainBtn.connect("pressed", self, "clicked", [$MainBtn])
	pass

func _physics_process(delta):
	if true:
		self.set_physics_process(false)
	pass
