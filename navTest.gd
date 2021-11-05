extends Node2D


export var navPath = NodePath()
onready var nav_2d = get_node(navPath)
export var linePath = NodePath()
onready var line_2d = get_node(linePath)
export var characterPath = NodePath()
onready var character = get_node(characterPath)
export var mainPath = NodePath()
onready var main = get_node(mainPath)

func _ready():
	var mainBody = main.get_node("PlayerBody")
	var mainStop = mainBody.get_node("Area2D")
	mainStop.connect("body_entered", character, "EnterPlayerRange")
	mainStop.connect("body_exited", character, "ExitPlayerRange")

func _process(delta):
	
	var charPos = character.get_node("PlayerBody").global_position
	var mainBody = main.get_node("PlayerBody")
	var mainPos = mainBody.global_position
	


	var new_path = nav_2d.get_simple_path(charPos, mainPos)
	line_2d.points = new_path
	character.path = new_path

