extends TextureButton

var Vs = [-2, -6, -8] # velocities for each "bounce"
var V; var a; var bounce; var origin;
func setup():
	self.disconnect("pressed", self, "setup")
	a = 0.5
	bounce = 2
	V = Vs[bounce]
	origin = self.get_position().y
	self.set_physics_process(true)
func step(c):
	c.y += V
	if c.y < origin: # on the rise
		V += a
		return c
	c.y = origin
	if bounce > 0: # bounce off the "ground"
		bounce -= 1
		V = Vs[bounce]
		return c
	# stop bouncing
	self.set_physics_process(false)
	self.connect("pressed", self, "setup")
	return c

func _ready():
	self.connect("pressed", self, "setup")
	self.set_physics_process(false)

func _physics_process(delta):
	self.set_position(step(self.get_position()))
