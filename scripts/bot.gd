extends KinematicBody2D

enum Orientation {UP, LEFT, DOWN, RIGHT}

# Member variables
const MOTION_SPEED = 70 # Pixels/second
const ROTATION_SPEED = 6

var velocity = Vector2(0, 0)

func _process(delta):
	# Rotate orientation.
	if (Input.is_key_pressed(KEY_E)):
		self.rotation = self.rotation + (ROTATION_SPEED * delta)

func randomInt(to):
	return randi() % to + 1

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
