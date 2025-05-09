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
@export var bounds_radius = 25.0 # radius of their boundaries
@export var water_surface_level : float

# AVOIDANCE vars
#var leave_boundary_time = 5.0
#var leave_boundary_timer = 0.0
@export var leave_boundary_bool : bool
@export var vision_radius: = 5.0 # fish viewing distance

#var wander_target : Vector3
var wander_timer = 0.0
@export var wander_interval: float
@export var wander_current_target : Vector3
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
	if leave_boundary_bool:
		if get_group_center().distance_to(bounds_center) < bounds_radius * 0.8:
			for fish in fish_list:
				fish.avoiding = false
				print("Left boundary, calcing new target")
				wander_calc()
			leave_boundary_bool = false
	elif current_behaviour == behaviourType.Wander and !leave_boundary_bool:
		if wander_timer >= wander_interval:
			wander_calc()
		if get_group_center().distance_to(wander_current_target) < vision_radius:
			print("reached target, recalcing")
			wander_calc()
		if abs(get_group_center().x) > bounds_radius - vision_radius or abs(get_group_center().y) > water_surface_level - vision_radius or abs(get_group_center().z) > bounds_radius - vision_radius:
				print(abs(get_group_center().x))
				print("Reached boundary, avoiding")
				leave_boundary_bool = true
				for fish in fish_list:
					fish.avoiding = true
		wander_timer += delta

func wander_calc():
	print("wander_calc run")
	wander_timer = 0
	# GET RANDOM POINT WITHIN SPHERE
	var t = randf() * TAU
	var p = acos(randf() * 2.0 - 1.0)
	
	var x = sin(p) * cos(t)
	var y = sin(p) * sin(t)
	y = clamp(y, bounds_center.y - bounds_radius, water_surface_level) # CLAMP Y VALUE BETWEEN SURFACE WATER LEVEL AND LOWEST POINT IN BOWL
	var z = cos(p)
	var dir = Vector3(x, y, z)
	var r = pow(randf(), 1.0 / 3.0) * bounds_radius
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
