extends Control

func _ready():
	add_user_signal("story_pressed", [])
	add_user_signal("sandbox_pressed", [])
	add_user_signal("editor_pressed", [])
	add_user_signal("online_pressed", [])
	add_user_signal("options_pressed", [])
	add_user_signal("logout_pressed", [])
	add_user_signal("close_main_menu_pressed", [])

func _on_StoryBtn_pressed():
	emit_signal("story_pressed", [])

func _on_SandboxBtn_pressed():
	emit_signal("sandbox_pressed", [])

func _on_EditorBtn_pressed():
	emit_signal("editor_pressed", [])

func _on_OnlineBtn_pressed():
	emit_signal("online_pressed", [])

func _on_OptionsBtn_pressed():
	var Desktop = get_node("../..")
	var OptionBox = get_node("../OptionBox")
	Desktop.maximize(OptionBox)
	emit_signal("options_pressed", [])

func _on_LogoutBtn_pressed():
	emit_signal("logout_pressed", null)

func _on_CloseBtn_pressed():
	var Desktop = get_node("../..")
	Desktop.minimize(self)
	emit_signal("close_main_menu_pressed", null)
