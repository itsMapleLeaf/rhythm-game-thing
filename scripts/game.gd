extends Node2D

var song_time = -3
var song_time_label: Label

var frames: Node2D

func _ready():
	frames = Node2D.new()
	add_child(frames)
	
	_add_frame({
		"start_time": 0,
		"end_time": 2,
		"notes": [
			{ "time": 0.0, "position": 0.00 },
			{ "time": 0.5, "position": 0.25 },
			{ "time": 1.0, "position": 0.50 },
			{ "time": 1.5, "position": 0.75 },
			{ "time": 2.0, "position": 1.00 },
		]
	})
	_add_frame({
		"start_time": 2.5,
		"end_time": 4.5,
		"notes": [
			{ "time": 0.0, "position": 1.00 },
			{ "time": 0.5, "position": 0.75 },
			{ "time": 1.0, "position": 0.50 },
			{ "time": 1.5, "position": 0.25 },
			{ "time": 2.0, "position": 0.00 },
		]
	})
	_add_frame({
		"start_time": 5,
		"end_time": 7,
		"notes": [
			{ "time": 0.0, "position": 0.00 },
			{ "time": 0.5, "position": 0.50 },
			{ "time": 1.0, "position": 1.00 },
			{ "time": 1.5, "position": 0.50 },
			{ "time": 2.0, "position": 0.00 },
		]
	})
	
	song_time_label = Label.new()
	song_time_label.rect_position += Vector2(20, 20)
	add_child(song_time_label)
	
func _add_frame(frame_data):
	var frame = Frame.new()
	frame.frame_data = frame_data
	frames.add_child(frame)

func _process(delta):
	song_time += delta * 0.75
	song_time_label.text = str(song_time)
	
	for frame in frames.get_children():
		frame.process_song_time(song_time)
	
func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		for frame in frames.get_children():
			frame.handle_touch(event.position, song_time)
