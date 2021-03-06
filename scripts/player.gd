extends "res://scripts/unit.gd"

enum Orientation {UP, LEFT, DOWN, RIGHT}

# Retrieve nodes.
onready var tileMap = get_node("../tileMap")

# Constants.
const MOTION_SPEED = 30
const PATH_SPEED_BOOST = 20
const ROTATION_SPEED = 2
const ROTATION_DIFFERENCE = 1

var velocity = Vector2(0, 0)
var targetRotation = null

func _ready():
	print(tileMap)
	
func _process(delta):
	# Rotate towards target rotation.
	if (targetRotation != null):
		if (self.rotation_degrees < targetRotation or self.rotation_degrees > targetRotation):
			if (abs(targetRotation - self.rotation_degrees)  < ROTATION_DIFFERENCE):
				self.rotation = deg2rad(targetRotation)
				targetRotation = null
			else:
				self.rotation = self.rotation + ROTATION_SPEED * delta
	# Rotate player.
	elif Input.is_key_pressed(KEY_E):
		self.rotation = self.rotation + ROTATION_SPEED * delta
		
func _input(event):
	if (event is InputEventKey):
		var key = event.scancode
		
		# Regenerate terrain.
		if key == KEY_R:
			tileMap.generate(self.position.x, self.position.y)
			print(self.position.x)
			print(self.position.y)
	
func _physics_process(delta):
	var motion = Vector2()
	
	if Input.is_action_pressed("move_up"):
		motion.y -= 1
	if Input.is_action_pressed("move_bottom"):
		motion.y += 1
	if Input.is_action_pressed("move_left"):
		motion.x -= 1
	if Input.is_action_pressed("move_right"):
		motion.x += 1
		
	# Create the speed buffer.
	var speed = MOTION_SPEED
	
	# Apply speed boost if entity is on a path.
	if (tileMap.getCellAt(self.position) == tileMap.Tile.GRASS):
		speed += PATH_SPEED_BOOST
	
	# Normalize motion.
	motion = motion.normalized() * speed
	
	# Apply motion.
	move_and_slide(motion)

func setTarget(target):
	if (velocity.x < target.x):
		velocity.x = 1
	elif (velocity.x > target.x):
		velocity.x = -1
	else:
		velocity.x = 0
	
	if (velocity.y < target.y):
		velocity.y = 1
	elif (velocity.y > target.y):
		velocity.y = -1
	else:
		velocity.y = 0

#func setOrientation(orientation):
	#if (orientation == Orientation.UP):
		#self.look_at(

func orientTowardsMouse():
	self.look_at(get_global_mouse_position())
	
func setTargetOrientation(orientation):
	# TODO
	pass
	
func move():
	var motion = Vector2()
	
	motion.x += velocity.x
	motion.y += velocity.y
	
	motion = motion.normalized() * MOTION_SPEED
	move_and_slide(motion)

func _on_MovementTimer_timeout():
	#move()
	#orientTowardsMouse()
	setTarget(get_global_mouse_position())
	#setOrientation(Orientation.UP)
	
	pass # Replace with function body.
