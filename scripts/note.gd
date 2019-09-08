extends Sprite
class_name Note

var note_texture = load("res://images/note.png")

var song_time = 0
var hit = false

func handle_hit():
	hit = true
	modulate.a = 0

func _ready():
	texture = note_texture
	pass
