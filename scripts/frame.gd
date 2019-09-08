extends Node2D
class_name Frame

const FRAME_PADDING_H = 250
const FRAME_PADDING_V = 100

const TIMING_WINDOW = 0.3

var timing_bar_texture = load("res://images/timing-bar.png")
var timing_bar: Sprite

var frame_data

var notes_container: Node2D

func process_song_time(song_time: float):
	_update_notes_visibility(song_time)
	_update_timing_bar(song_time)

func handle_touch(tap_position: Vector2, song_time: float) -> bool:
	var notes = notes_container.get_children()
	
	for note in notes:
		if not note is Note: continue
		if note.hit: continue
		
		var distance = note.global_position.distance_to(tap_position)
		var timing = abs(song_time - note.time)
		
		if distance < 100 and timing < TIMING_WINDOW:
			note.handle_hit()
			return true
	
	return false

func _ready():
	_create_notes()
	_create_timing_bar()

func _update_timing_bar(song_time: float):
	if timing_bar == null: return
	
	var viewport_size = get_viewport_rect().size
	var frame_position_delta = inverse_lerp(frame_data.start_time, frame_data.end_time, song_time)
	timing_bar.position.x = lerp(FRAME_PADDING_H, viewport_size.x - FRAME_PADDING_H, frame_position_delta)
	
func _update_notes_visibility(song_time: float):
	if notes_container == null: return
	
	var is_frame_visible = song_time > frame_data.start_time - 0.5 and song_time < frame_data.end_time + TIMING_WINDOW
	if is_frame_visible:
		notes_container.modulate.a = 1
	else:
		notes_container.modulate.a = 0

func _create_notes():
	var viewport_size = get_viewport_rect().size
	
	notes_container = Node2D.new()
	add_child(notes_container)
	
	for note in frame_data.notes:
		var note_song_time = frame_data.start_time + note.time
		var time_delta = inverse_lerp(frame_data.start_time, frame_data.end_time, note_song_time)
		
		var x = lerp(0 + FRAME_PADDING_H, viewport_size.x - FRAME_PADDING_H, time_delta)
		var y = lerp(0 + FRAME_PADDING_V, viewport_size.y - FRAME_PADDING_V, note.position)
	
		var note_instance = Note.new()
		note_instance.position = Vector2(x, y)
		note_instance.time = note_song_time
		
		notes_container.add_child(note_instance)
		
func _create_timing_bar():
	var viewport_size = get_viewport().size
	
	timing_bar = Sprite.new()
	timing_bar.position = Vector2(FRAME_PADDING_H, viewport_size.y / 2)
	timing_bar.texture = timing_bar_texture
	
	add_child(timing_bar)
