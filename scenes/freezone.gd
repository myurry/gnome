extends Area2D


func _on_area_entered(body: Node2D) -> void:
	body.queue_free()
	
