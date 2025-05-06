extends Node3D

enum AIState
{
	SEEK,
	FLEE,
	WANDER,
	ARRIVE,
	PURSUE,
	AVOID
}
var fish_list: Array[CharacterBody3D] = []

func _ready():
	fish_list = get_children().filter(func(c): return c is CharacterBody3D)

func get_neighbors(fish: CharacterBody3D) -> Array:
	return fish_list
