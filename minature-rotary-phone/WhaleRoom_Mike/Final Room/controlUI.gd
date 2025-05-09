extends Control
var Speed 
var Cohere
var Wander

func _ready() -> void:
	
	pass
	
	


func _on_speed_value_changed(value: float) -> void:
	print_debug('speedValueChange')
	$"../../FISHES/Fish".speed = value
	$"../../FISHES/Fish2".speed = value
	$"../../FISHES/Fish3".speed = value
	$"../../FISHES/Fish4".speed = value
	$"../../FISHES/Fish5".speed = value
	$"../../FISHES/Fish6".speed = value
	$"../../FISHES/Fish7".speed = value
	$"../../FISHES/Fish8".speed = value
	$"../../FISHES/Fish9".speed = value
	$"../../FISHES/Fish10".speed = value
	pass # Replace with function body.




func _on_wander_value_changed(value: float) -> void:
	print_debug('wanderValueChange')
	$"../../FISHES/Fish".wander_weight = value
	$"../../FISHES/Fish2".wander_weight = value
	$"../../FISHES/Fish3".wander_weight = value
	$"../../FISHES/Fish4".wander_weight = value
	$"../../FISHES/Fish5".wander_weight = value
	$"../../FISHES/Fish6".wander_weight = value
	$"../../FISHES/Fish7".wander_weight = value
	$"../../FISHES/Fish8".wander_weight = value
	$"../../FISHES/Fish9".wander_weight = value
	$"../../FISHES/Fish10".wander_weight = value
	pass # Replace with function body.


func _on_cohesion_value_changed(value: float) -> void:
	print_debug('CohesionValueChange')
	$"../../FISHES/Fish".cohesion_weight = value
	$"../../FISHES/Fish2".cohesion_weight = value
	$"../../FISHES/Fish3".cohesion_weight = value
	$"../../FISHES/Fish4".cohesion_weight = value
	$"../../FISHES/Fish5".cohesion_weight = value
	$"../../FISHES/Fish6".cohesion_weight = value
	$"../../FISHES/Fish7".cohesion_weight = value
	$"../../FISHES/Fish8".cohesion_weight = value
	$"../../FISHES/Fish9".cohesion_weight = value
	$"../../FISHES/Fish10".cohesion_weight = value
	pass # Replace with function body.


func _on_whale_g_toggled(toggled_on: bool) -> void:
	if toggled_on:
		$"../../creature/boid".draw_gizmos = true
		$"../../creature/boid/Avoidance".draw_gizmos = true
		$"../../creature/boid/Harmonic".draw_gizmos = true
		$"../../creature/boid/Constrain".draw_gizmos = true
		$"../../creature/boid/NoiseWander".draw_gizmos = true
		$"../../creature/boid/PathFollow3D".draw_gizmos = true
	
		$"../../creature2/boid".draw_gizmos = true
		$"../../creature2/boid/Avoidance".draw_gizmos = true
		$"../../creature2/boid/Harmonic".draw_gizmos = true
		$"../../creature2/boid/Constrain".draw_gizmos = true
		$"../../creature2/boid/NoiseWander".draw_gizmos = true
	else:
		$"../../creature/boid".draw_gizmos = false
		$"../../creature/boid/Avoidance".draw_gizmos = false
		$"../../creature/boid/Harmonic".draw_gizmos = false
		$"../../creature/boid/Constrain".draw_gizmos = false
		$"../../creature/boid/NoiseWander".draw_gizmos = false
		$"../../creature/boid/PathFollow3D".draw_gizmos = false
	
		$"../../creature2/boid".draw_gizmos = false
		$"../../creature2/boid/Avoidance".draw_gizmos = false
		$"../../creature2/boid/Harmonic".draw_gizmos = false
		$"../../creature2/boid/Constrain".draw_gizmos = false
		$"../../creature2/boid/NoiseWander".draw_gizmos = false
	pass # Replace with function body.


func _on_fishe_g_toggled(toggled_on: bool) -> void:
	
	pass # Replace with function body.
