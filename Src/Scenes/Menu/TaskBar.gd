extends Node2D

var Vs = [-2, -6, -8] # velocities for each "bounce"
var V
var a
var bounce
var origin
var actor
func setup(act):
	actor = act
	a = 0.5
	bounce = 2
	V = Vs[bounce]
	origin = actor.get_position().y
func step(c):
	c.y += V
	if c.y < origin: # on the rise
		V += a
		return c
	if bounce > 0: # bounce off the "ground"
		bounce -= 1
		V = Vs[bounce]
		return c
	# stop bouncing
	self.set_physics_process(false)
	return c

func clicked(btn):
	setup(btn)
	self.set_physics_process(true)

func _ready():
	self.set_physics_process(false)
	$MainBtn.connect("pressed", self, "clicked", [$MainBtn])
	pass

func _physics_process(delta):
	actor.set_position(step(actor.get_position()))
