extends Sprite
class_name Note

var note_texture = load("res://images/icon.png")

var time = 0
var hit = false

func handle_hit():
	hit = true
	modulate.a = 0

func _ready():
	texture = note_texture
	pass
