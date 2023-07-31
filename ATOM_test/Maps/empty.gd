extends Node3D

var default_scene = "res://ATOM_test/Maps/TestLevel.tscn" # Change this to the path of the scene you want to load

func _on_button_pressed():
	get_tree().change_scene_to_file(default_scene)
