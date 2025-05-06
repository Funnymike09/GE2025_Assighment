extends Node3D
# our list of fish! :D
var fish_list: Array[CharacterBody3D] = []

func _ready():
	# get fish from children nodes
	# note to self keep fish as first-layer children
	fish_list = get_children().filter(func(c): return c is CharacterBody3D)

# let the fish see where their neighbors are
func get_neighbors(fish: CharacterBody3D) -> Array:
	return fish_list
