extends Node

var confirmation_dialog # for quit confirmation dialog
var message_dialog # for message dialog
var scene_change_dialog # for scene change confirmation dialog
var empty_scene = "res://ATOM_test/Maps/empty.tscn" # Change this to the path of the scene you want to load
var buttons = [] # Initialize an empty array to buttons

func _ready():
	randomize()
	# Initialize dialogs here
	confirmation_dialog = ConfirmationDialog.new()
	confirmation_dialog.connect("confirmed", Callable(self, "_on_quit_confirmed"))
	confirmation_dialog.get_ok_button().text = "Да"
	confirmation_dialog.get_cancel_button().text = "Нет"
	confirmation_dialog.title = "Выход"
	confirmation_dialog.dialog_text = "Вы действительно хотите выйти?" 
	add_child(confirmation_dialog)

	message_dialog = AcceptDialog.new()
	message_dialog.connect("confirmed", Callable(self, "_on_message_dialog_confirmed"))
	add_child(message_dialog)

	scene_change_dialog = ConfirmationDialog.new()
	scene_change_dialog.connect("confirmed", Callable(self, "_on_scene_change_confirmed"))
	scene_change_dialog.get_ok_button().text = "Переход"
	scene_change_dialog.get_cancel_button().text = "Отмена"
	scene_change_dialog.title = "Ненавижу порталы"
	scene_change_dialog.dialog_text = "Вы действительно хотите перейти?" 
	add_child(scene_change_dialog)
	
		# Assuming buttons are children of a Node named "CanvasLayer"
	for child in $CanvasLayer.get_children():
		if child is Button:
			buttons.append(child)

func _on_button_1_pressed():
	scene_change_dialog.popup_centered() # Show the scene change dialog

func _on_button_2_pressed():
	$CanvasLayer/Button2.modulate = Color(randf_range(0, 1), randf_range(0, 1), randf_range(0, 1), 1) # Random color
	await get_tree().create_timer(0.5).timeout # Wait for half a second
	$CanvasLayer/Button2.modulate = Color(1, 1, 1, 1) # Return the button to its original color

func _on_button_3_pressed():
	randomize_button_positions()

func _on_button_4_pressed():
	confirmation_dialog.popup_centered() # Ask the user to confirm quitting

func _on_quit_confirmed():
	get_tree().quit() # Quit the game

func _on_scene_change_confirmed():
	get_tree().change_scene_to_file(empty_scene) # Switch to the new scene

func randomize_button_positions():

	var positions = [] # Create an empty array to hold the current positions of the buttons
	for button in buttons:
		positions.append(button.position) # Add each button's current position to the array
	positions.shuffle() # Randomly rearrange the order of the positions in the array
	for i in range(buttons.size()):
		buttons[i].position = positions[i] # Assign each button a new position from the shuffled array
