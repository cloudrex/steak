extends KinematicBody2D

enum Orientation {UP, LEFT, DOWN, RIGHT}

# Member variables
const MOTION_SPEED = 50 # Pixels/second

var velocity = Vector2(0, 0)

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
	
	motion = motion.normalized() * MOTION_SPEED

	move_and_slide(motion)

func setTarget(target):
	if (velocity.x < target.x):
		velocity.x = 1
	
	if (velocity.y < target.y):
		velocity.y = 1
		
	if (velocity.x > target.x):
		velocity.x = -1
		
	if (velocity.y > target.y):
		velocity.y = -1

func orientTowardsMouse():
	self.look_at(get_global_mouse_position())
	
func move():
	var motion = Vector2()
	
	motion.x += velocity.x
	motion.y += velocity.y
	
	motion = motion.normalized() * MOTION_SPEED
	move_and_slide(motion)

func _on_MovementTimer_timeout():
	move()
	orientTowardsMouse()
	setTarget(get_global_mouse_position())
	pass # Replace with function body.
