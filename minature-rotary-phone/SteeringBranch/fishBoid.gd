extends CharacterBody3D

# Tweakable behaviour variables
@export var speed: = 5.0 # base speed
@export var vision_radius: = 10.0 # fish viewing distance
@export var seperation_distance : = 6.0 # distance to keep between fish

#BOID variables - can change these to affect how they prioritise each behavior
@export var alignment_weight: = 1.0
@export var cohesion_weight: = 1.0
@export var seperation_weight: = 1.5

# ref to manager script
@onready var boidManager = get_parent()

# optional local targets
#var interest_pos : Vector3
var threat_pos : Vector3
# wander settings
var wander_target : Vector3
var wander_timer = 0.0
@export var wander_interval = 15.0
@export var wander_radius = 20.0

func wander(delta: float) -> Vector3:
	print("Wander timer: " + str(wander_timer))
	if wander_timer < wander_interval:
		wander_timer += delta
	else:
		var rand_dir = Vector3(randf_range(-1.0, 1.0), randf_range(-0.5, 0.5), randf_range(-1.0, 1.0))
		wander_target = global_position + rand_dir * wander_radius
		wander_timer = 0.0
	return (wander_target - global_position).normalized()

func seek(target: Vector3) -> Vector3:
	var desired_pos = (target - global_position).normalized() * speed
	return (desired_pos - velocity).limit_length(speed)

func arrive(target: Vector3) -> Vector3:
	return Vector3.ZERO # temp

func flee():
	pass

func _ready():
	# checking boidmanager node exists
	#if boidManager == null and get_parent().has_method("get_neighbors"):
		#boidManager = get_parent()
	pass

func _physics_process(delta: float) -> void:
	var neighbors = get_neighbors() # get all other fish
	var alignment = Vector3.ZERO
	var cohesion = Vector3.ZERO
	var seperation = Vector3.ZERO
	var neighborCount = 0
	
	for neighbor in neighbors:
		var offset = neighbor.global_position - global_position
		var distance = offset.length()
		# neighbor calls all fish so make sure its not calling self
		if distance < vision_radius and neighbor != self: # within vision radius
			alignment += neighbor.velocity # match velocity
			cohesion += neighbor.global_position # move towards group centre
			# seperation - move away if too close
			if distance < seperation_distance and distance > 0:
				seperation -= offset.normalized() / distance 
			# else: print("Seperation vector length is 0 or less") #<- debugging
			# increase neighbor count
			neighborCount += 1
	
	if neighborCount > 0: # check this fish actually has neighbors
		# calc average alignment direction of the crowd by averaging the velocity
		if alignment.length() > 0: # make sure we're not normalizing a zero vector
			alignment = (alignment/neighborCount).normalized()
		else: print("Alignment vector length is 0 or less")
		# steer towards the average pos of crowd 
		if cohesion.length() > 0: # make sure we're not normalizing a zero vector
			cohesion = ((cohesion / neighborCount) - global_position).normalized()
		else: print("Cohesion vector length is 0 or less")
		# seperation calced above
		
		# combine behaviours into direction vector
		var boid_dir = (alignment * alignment_weight
		+ cohesion * cohesion_weight
		+ seperation * seperation_weight) 
		
		var direction
		var current_behaviour = boidManager.current_behaviour
		match current_behaviour:
			boidManager.behaviourType.Wander:
				var wander_dir = wander(delta)
				direction = boid_dir + wander_dir * 0.5
		
		if direction.length() > 0: # make sure the direction actually has a length
			direction = direction.normalized() # now direction's length isnt 0 we can safely normalize
		#lerp towards the new dir
		velocity = velocity.lerp(direction * speed, 0.1) # weight low to keep smooth movement hopefully
	# limit length of velocity to our speed variable
	velocity = velocity.limit_length(speed)
	move_and_slide() # how we shmove
	# rotate fish here
	look_at(wander_target, Vector3.UP)
	on_draw_gizmos()
	print("Wander target: " + str(wander_target))

# gets neighbors from boidManager
func get_neighbors() -> Array:
	var current = get_parent()
	if current != null:
		if current.has_method("get_neighbors"): # check the parent node has right script with func
			return current.get_neighbors(self)
		current = current.get_parent()
	return [] # returns the whole array

func get_group_center() -> Vector3:
	var avg_pos = Vector3.ZERO
	for fish in boidManager.fish_list:
		avg_pos += fish.global_position
	avg_pos /= boidManager.fish_list.size()
	return avg_pos

func on_draw_gizmos():
	DebugDraw3D.draw_line(global_transform.origin, global_transform * (Vector3.BACK * 10))
