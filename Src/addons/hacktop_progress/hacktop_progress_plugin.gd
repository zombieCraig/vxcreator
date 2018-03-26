tool
extends EditorPlugin

func get_name():
    return "HacktopProgress"

func _start():
    # Initialization of the plugin goes here
    #add_custom_type("HacktopProgressBar", "Node2D", preload("HacktopProgress.gd"), preload("icon.png"))
    add_custom_type("HacktopProgressBar", "Node2D", preload("res://addons/hacktop_progress/HacktopProgress.gd"), preload("res://addons/hacktop_progress/icon.png"))

func _stop():
    # Clean-up of the plugin goes here
    remove_custom_type("HacktopProgressBar")

func _enter_tree():
    _start()

func _exit_tree():
    _stop()
