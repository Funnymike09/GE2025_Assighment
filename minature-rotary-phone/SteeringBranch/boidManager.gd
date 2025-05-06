extends Node3D
# our list of fish! :D
var fish_list: Array[CharacterBody3D] = []

func _ready():
	# get fish from children nodes
	# note to self keep fish as first-layer children - this should filter out non-fish but you never know
	
	var children = get_children()
	for child in children:
		if child.get_script() and child.get_script().resource_path == "res://SteeringBranch/fishBoid.gd": # make sure node has the script
			fish_list.append(child)
	
	#fish_list = get_children().filter(func(c): return c is CharacterBody3D) as Array[CharacterBody3D]
	#fish_list = fish_list.map(func(c): return c as CharacterBody3D).filter(f)

# let the fish see where their neighbors are
func get_neighbors(fish: CharacterBody3D) -> Array[CharacterBody3D]:
	return fish_list
