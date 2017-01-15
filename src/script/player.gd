extends KinematicBody2D

const MAXIMUM_HEALTH = 100
const MOVE_SPEED = 300

const ROTATION_RAD = (PI / 180) * 90
const CLOCK_WISE = Vector2(-1, 0)
const COUNTER_CLOCK_WISE = Vector2(1, 0)

var move_dir = Vector2()
var velocity = Vector2()
var motion = Vector2()

onready var health = get_node("health")
onready var force_target = get_node("Force_Target")

func initialize():
	health.set_current(MAXIMUM_HEALTH)
	health.set_maximum(MAXIMUM_HEALTH)

func _ready():
	initialize()
	set_process(true)
	set_process_input(true)
	set_fixed_process(true)

func _input(event):
	if event.is_action_pressed("rotate_left"):
		if not event.is_echo() and not health.is_empty():
			_rotate(COUNTER_CLOCK_WISE)
	elif event.is_action_pressed("rotate_right"):
		if not event.is_echo() and not health.is_empty():
			_rotate(CLOCK_WISE)

func _process(delta):
	move_dir = (force_target.get_global_pos() - get_global_pos()).normalized()

func _fixed_process(delta):
	velocity = move_dir * MOVE_SPEED
	motion = velocity * delta
	if is_colliding():
		get_collision_normal().slide(motion)
	move(motion)

func _rotate(direction):
	if get_rotd() >= 360 or get_rotd() <= -360:
		set_rotd(0)
	rotate(ROTATION_RAD * direction.x)
