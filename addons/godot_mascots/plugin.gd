@tool
extends EditorPlugin

var scene: Control = preload("res://addons/godot_mascots/godot_mascots.tscn").instantiate()

func _enable_plugin() -> void:
	add_control_to_dock(EditorPlugin.DOCK_SLOT_LEFT_BL, scene)

func _disable_plugin() -> void:
	remove_control_from_docks(scene)


func _enter_tree() -> void:
	pass

func _exit_tree() -> void:
	pass
