extends Node2D

func _ready():
	add_child(Gameplay.new())

func _input(event):
	if event is InputEventKey and event.scancode == KEY_ESCAPE:
		get_tree().quit()