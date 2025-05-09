extends Node
@export var out: FmodEventEmitter3D
@export var land: FmodEventEmitter3D

func _on_area_3d_area_entered(area: Area3D) -> void:
	land.play_one_shot()
	pass # Replace with function body.


func _on_area_3d_area_exited(area: Area3D) -> void:
	out.play_one_shot()
	pass # Replace with function body.
