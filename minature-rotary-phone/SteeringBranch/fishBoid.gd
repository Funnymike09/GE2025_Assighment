extends CharacterBody3D

# Tweakable behaviour variables
@export var speed: = 5.0 # base speed
@export var seperation_distance : = 6.0 # distance to keep between fish

#BOID steering modify variables - can change these to affect how they prioritise each behavior
@export var alignment_weight: = 1.0
@export var cohesion_weight: = 1.0
@export var seperation_weight: = 1.5
@export var wander_weight = 1.0
@export var rotation_speed = 3.0

# ref to manager script
var boidManager

# optional local targets
#var interest_pos : Vector3
var threat_pos : Vector3
var current_behaviour
@export var wander_target : Vector3
var vision_radius : float

func _ready():
	# checking boidmanager node exists
	if boidManager == null and get_parent().has_method("get_neighbors"):
		boidManager = get_parent()
		current_behaviour = boidManager.current_behaviour
		vision_radius = boidManager.vision_radius

func _physics_process(delta: float) -> void:
	# limit length of velocity to our speed variable
	var steer_target = boid_calc()
	var target = (steer_target + wander_target * wander_weight)
	velocity = velocity.lerp(target * speed, 0.1)
	velocity = velocity.limit_length(speed)
	
	# rotate fish here
	var new_transform = transform.looking_at(wander_target, Vector3.UP)
	transform = transform.interpolate_with(new_transform, rotation_speed * delta)
	global_position.y = clamp(global_position.y, -15, 7)
	global_position.x = clamp(global_position.x, -15, 15)
	global_position.z = clamp(global_position.z, -15, 15)
	move_and_slide() # how we shmove
	on_draw_gizmos()
	#print("Wander target: " + str(wander_target))

func boid_calc() -> Vector3:
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
		else: print("DBUG Alignment vector length is 0 or less")
		# steer towards the average pos of crowd 
		if cohesion.length() > 0: # make sure we're not normalizing a zero vector
			cohesion = ((cohesion / neighborCount) - global_position).normalized()
		else: print("DBUG Cohesion vector length is 0 or less")
		# seperation calced above
		
		# combine behaviours into direction vector
		var direction = (alignment * alignment_weight
		+ cohesion * cohesion_weight
		+ seperation * seperation_weight) 
		
		if direction.length() > 0: # make sure the direction actually has a length
			direction = direction.normalized() # now direction's length isnt 0 we can safely normalize
		return direction
		#lerp towards the new dir
	# basically a catch statement if obj has no neighbors just go forward
	return Vector3.FORWARD

# gets neighbors from boidManager
func get_neighbors() -> Array:
	var current = get_parent()
	if current != null:
		if current.has_method("get_neighbors"): # check the parent node has right script with func
			return current.get_neighbors(self)
		current = current.get_parent()
	return [] # returns the whole array

func on_draw_gizmos():
	DebugDraw3D.draw_line(global_transform.origin, global_transform * (Vector3.FORWARD * 10))
