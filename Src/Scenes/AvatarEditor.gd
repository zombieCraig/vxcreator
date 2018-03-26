extends Node2D

var CURSOR_FADE_SPEED = 1
var PALETTE_COLS = 17
var PALETTE_ROWS = 11

var palette_ts = null
var tool_selected = Vector2()
var tool_cursor = Vector2()
var palette_selected = Vector2()
var palette_cursor = Vector2()
var tool_id = -1

# Retrieves the cusor selection position over a tilemap
func get_cursor_pos(tilemap):
	var mouse = get_global_mouse_position()
	var tool_pos = tilemap.world_to_map(mouse)
	var world_pos = tilemap.map_to_world(tool_pos, true)
	return world_pos

# Gets the cell ID for a given tilemap as current mouse position
func get_cell_id(tilemap):
	print("DEBUG: pos ", tilemap.world_to_map(get_global_mouse_position()) - Vector2(7, 7)) # BUG: Not sure why not 0,0
	print("DEBUG: get_cellv ", tilemap.get_cellv(tilemap.world_to_map(get_global_mouse_position())))
	print("DEBUG: get_cellv2 ", tilemap.get_cellv(get_global_mouse_position()))
	return tilemap.get_cellv(tilemap.world_to_map(get_global_mouse_position()))

# Resets the fading opacity on the cursor and position, position set elsewhere
func update_cursor(cursor, pos):
	cursor.show()
	cursor.modulate.a = 1.0
	cursor.global_position = pos

func prep_palette():
	palette_ts = TileSet.new()
	$BG/PaletteArea/Palette.tile_set = palette_ts
	var c = preload("res://Images/palette.png")
	var total_tiles = 0
	var current_color = Color(0x33, 0, 0)
	var g_dir = 1
	for column in PALETTE_COLS:
		palette_ts.create_tile(total_tiles)
		palette_ts.tile_set_texture(total_tiles, c)
		print(current_color)
		palette_ts.set(str(total_tiles,"/modulate"), current_color)
#		$BG/PaletteArea/Palette.set_cell(total_tiles, 0, column)
		if g_dir == 1:
			current_color[1] += 0x33
			if current_color[1] > 0xFF:
				g_dir = -1
				current_color[1] = 0xFF
				current_color[0] += 0x33
		elif g_dir == -1:
			current_color[1] -= 0x33
			if current_color[1] < 0:
				g_dir = 1
				current_color[1] = 0
				current_color[0] += 0x33
		total_tiles += 1

	var row = 0
	var col = 0
	for tile in total_tiles:
		$BG/PaletteArea/Palette.set_cell(tile, row, col)
		col += 1
		if col > PALETTE_COLS:
			col = 0
			row += 1

func _process(delta):
	if $BG/ToolArea/Tools/Cursor.visible:
		$BG/ToolArea/Tools/Cursor.modulate.a -= (CURSOR_FADE_SPEED * delta)
		if $BG/ToolArea/Tools/Cursor.modulate.a < 0.1:
			$BG/ToolArea/Tools/Cursor.hide()

func _ready():
	prep_palette()

func _on_tool_input_event( viewport, event, shape_idx ):
	tool_cursor = get_cursor_pos($BG/ToolArea/Tools)
	update_cursor($BG/ToolArea/Tools/Cursor, tool_cursor)
	if event.is_action_pressed("mouse_lclick"):
		$BG/ToolArea/Tools/Selected.global_position = tool_cursor
		tool_id = get_cell_id($BG/ToolArea/Tools)
		print("Selected tool_Id ", tool_id)

func _on_CanvasArea_mouse_entered():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _on_CanvasArea_mouse_exited():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_CanvasArea_input_event( viewport, event, shape_idx ):
	if event.is_action_pressed("mouse_lclick"):
		var canvas_pos = $BG/CanvasArea/Canvas.world_to_map(get_global_mouse_position())
		$BG/CanvasArea/Canvas.set_cellv(canvas_pos, tool_id)
		print("PLanted tool id", tool_id, " here ", canvas_pos)
