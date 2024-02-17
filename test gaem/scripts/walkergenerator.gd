extends Node2D
class_name Walker

const DIRECTIONS = [Vector2.RIGHT, Vector2.UP, Vector2.LEFT, Vector2.DOWN]

var position_ = Vector2.ZERO
var direction = Vector2.RIGHT

var borders = Rect2()

var step_history = []
var steps_since_turn = 0


func _init(starting_position, new_borders):
	assert(new_borders.has_point(starting_position))
	position_ = starting_position
	step_history.append(position_)
	borders = new_borders


func walk(steps):
	for step in steps:
		if randf() <= 0.25 or steps_since_turn >= 4:
			change_direction()
		
		if step():
			step_history.append(position_)
		else:
			change_direction()
	return step_history


func step():
	var target_position = position_ + direction
	if borders.has_point(target_position):
		steps_since_turn += 1
		position_ = target_position
		return true
	else:
		return false


func change_direction():
	steps_since_turn = 0
	var directions = DIRECTIONS.duplicate()
	directions.erase(direction)
	directions.shuffle()
	direction = directions.pop_front()
	while not borders.has_point(position_ + direction):
		direction = directions.pop_front()


