extends Camera3D

@export var follow_distance = 15.0
@export var height = 5.0
@export var follow_speed = 5.0
@onready var boidManager = get_parent()

#get our fish so we can target the group and not individual
var fish_list: Array[CharacterBody3D] = [] # only referencing positions so node should work

func _ready() -> void:
	if boidManager != null and boidManager.has_method("get_neighbors"): # make 100% sure we getting the right node
		fish_list = boidManager.fish_list
	else: print("Can't find boid manager on camera script")

func get_average_pos() -> Vector3: # return a vector3
	var avg_pos = Vector3.ZERO
	for fish in fish_list:
		avg_pos += fish.global_position
	avg_pos /= fish_list.size() # average the fish positions
	return avg_pos

func _physics_process(delta: float) -> void: # my favourite function
	if fish_list.size() == 0: return # in case of empty array, exit to prevent errors
	var target_pos = get_average_pos()
	# calc our desired pos based on our exported vars
	var desired_pos = target_pos + Vector3.BACK * follow_distance + Vector3.UP * height
	global_position = global_position.lerp(desired_pos, delta * follow_speed)
	
	look_at(target_pos, Vector3.UP) # set rotation to look at target pos
