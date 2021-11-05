extends Node2D


export var navPath = NodePath()
onready var nav_2d = get_node(navPath)
export var linePath = NodePath()
onready var line_2d = get_node(linePath)
export var characterPath = NodePath()
onready var character = get_node(characterPath)
export var mainPath = NodePath()
onready var main = get_node(mainPath)

func _process(delta):
	
	
	var charPos = character.global_position
	var mainPos = main.get_node("PlayerBody").global_position
	
	var distance = 280
	
	
	var dist = charPos - mainPos
	var ta = atan2(dist.y,dist.x)
	var tance = Vector2()
	tance.x = cos(ta)
	tance.y = sin(ta)
	tance *= distance
	var add =-tance + dist
	var new_path = nav_2d.get_simple_path(charPos, charPos + add)
	line_2d.points = new_path
	character.path = new_path
