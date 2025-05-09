extends Node3D
@export var Cam:CharacterBody3D
@export var Surface: Node3D
@export var speaker: FmodEventEmitter3D
var distance

func _process(delta: float) -> void:
	_depthCeck()

func _depthCeck()-> void:
	distance = global_position.distance_to(Cam.global_position)
	#print_debug(distance)
func paramFmod() -> void:
	speaker.set_parameter('DeepLVL', distance)
	pass
