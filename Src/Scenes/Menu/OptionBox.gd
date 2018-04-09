extends Node2D

func savePrefs():
	global.prefs["Fullscreen"] = get_node("FullScreenToggle").is_pressed()
	global.prefs["Sound"] = get_node("SoundEffectsToggle").is_pressed()
	global.prefs["ShowWelcomeMsg"] = get_node("WelcomeMsgToggle").is_pressed()
	var prefFile = File.new()
	prefFile.open(global.PREF_FILE, File.WRITE)
	prefFile.store_string(to_json(global.prefs))
	OS.set_window_fullscreen(global.prefs["Fullscreen"])

func _ready():
	add_user_signal("fullscreen_pressed", [])
	add_user_signal("sound_effects_pressed", [])
	add_user_signal("show_welcome_message_pressed", [])
	add_user_signal("option_back_pressed", [])
	if global.prefs.size() > 0:
		get_node("FullScreenToggle").set_pressed(global.prefs["Fullscreen"])
		get_node("SoundEffectsToggle").set_pressed(global.prefs["Sound"])
		get_node("WelcomeMsgToggle").set_pressed(global.prefs["ShowWelcomeMsg"])

func _on_FullScreenToggle_toggled( pressed ):
	emit_signal("fullscreen_pressed", pressed)

func _on_SoundEffectsToggle_toggled( pressed ):
	emit_signal("sound_effects_pressed", null)

func _on_WelcomeMsgToggle_toggled( pressed ):
	emit_signal("show_welcome_message_pressed", null)

func _on_BackButton_pressed():
	savePrefs()
	emit_signal("option_back_pressed", null)