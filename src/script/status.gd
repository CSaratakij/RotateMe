extends Node

export var current = 0
export var maximum = 0

func full_restore():
	current = maximum

func clear():
	current = 0

func restore(value):
	current = clamp(current + value, 0, maximum)

func remove(value):
	current = clamp(current - value, 0, maximum)

func is_empty():
	return current <= 0

func set_current(value):
	current = value

func set_maximum(value):
	maximum = value

func get_current():
	return current

func get_maximum():
	return maximum
