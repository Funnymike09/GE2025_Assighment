extends Node3D

enum behaviourType # state machine for different behaviours
{
	Wander, # standard behaviour state
	Seek, # if something interesting look for it
	Arrive, # when close to seek target
	Flee # when close to whale
}

var current_behaviour : behaviourType = behaviourType.Wander

# our list of fish! :D
var fish_list: Array[CharacterBody3D] = []
@export var bounds_center = Vector3.ZERO # center point of the fish' boundaries
@export var bounds_radius_horizontal = 25.0 # horizontal radius of their boundaries
@export var bounds_radius_vertical = 16.0
@export var water_surface_level : float

# AVOIDANCE vars
#var leave_boundary_time = 5.0
#var leave_boundary_timer = 0.0
@export var vision_radius: = 5.0 # fish viewing distance

#var wander_target : Vector3
var wander_timer = 0.0
@export var wander_interval: float
@export var wander_current_target : Vector3
@export var OOB : bool
#@export var wander_radius: float

func _ready():
	# get fish from children nodes
	# note to self keep fish as first-layer children - this should filter out non-fish but you never know
	var children = get_children()
	for child in children:
		if child.get_script() and child.get_script().resource_path == "res://SteeringBranch/fishBoid.gd": # make sure node has the script
			fish_list.append(child)
	if current_behaviour == behaviourType.Wander:
		wander_calc()

func _physics_process(delta: float) -> void:
	if get_group_center().distance_to(bounds_center) > bounds_radius_horizontal and !OOB or get_group_center().y < -24 and get_group_center().y > water_surface_level and  !OOB:
		if get_group_center().distance_to(bounds_center) > bounds_radius_horizontal : print("DBUG Out of horizontal boundary calcing new target")
		else : print("DBUG Out of vertical boundary calcing new target")
		OOB = true
		wander_calc()
	elif get_group_center().distance_to(bounds_center) < bounds_radius_horizontal or abs(get_group_center().y) - bounds_radius_vertical > 0:
		OOB = false
	if current_behaviour == behaviourType.Wander:
		if wander_timer >= wander_interval:
			wander_calc()
		if get_group_center().distance_to(wander_current_target) < vision_radius:
			print("DBUG reached target, recalcing")
			wander_calc()
		wander_timer += delta

func wander_calc():
	print("DBUG wander_calc run")
	wander_timer = 0
	# GET RANDOM POINT WITHIN SPHERE
	var t = randf() * TAU
	var p = acos(randf() * 2.0 - 1.0)
	
	var x = sin(p) * cos(t)
	var y = sin(p) * sin(t)
	y = clamp(y, -15, water_surface_level) # CLAMP Y VALUE BETWEEN SURFACE WATER LEVEL AND LOWEST POINT IN BOWL
	var z = cos(p)
	x = clamp(x, -15, 15)
	z = clamp(z, -15, 15)
	var dir = Vector3(x, y, z)
	var r = pow(randf(), 1.0 / 3.0) * bounds_radius_horizontal
	wander_current_target = bounds_center + dir * r
	for fish in fish_list:
		fish.wander_target = wander_current_target
# let the fish see where their neighbors are
func get_neighbors(fish: CharacterBody3D) -> Array[CharacterBody3D]:
	return fish_list

func get_group_center() -> Vector3:
	var avg_pos = Vector3.ZERO
	for fish in fish_list:
		avg_pos += fish.global_position
	avg_pos /= fish_list.size()
	return avg_pos
