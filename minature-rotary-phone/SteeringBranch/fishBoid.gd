extends CharacterBody3D

@export var speed : float
@export var max_speed: float
@export var vision_radius: float
@export var flee_radius: float
@export var avoid_radius: float
@export var mass: float
@export var vel: float
@export var max_force: float

func _physics_process(delta: float) -> void:
	var neighbors = get_neighbors() # get all other fish
	var alignment = Vector3.ZERO
	var count = 0
	pass

func get_neighbors() -> Array:
	var current = get_parent()
	if current != null:
		if current.has_method("get_neighbors"):
			return current.get_neighbors(self)
		current = current.get_parent()
	return []
