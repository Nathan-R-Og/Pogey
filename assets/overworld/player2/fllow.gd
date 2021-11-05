extends Node2D


export var record = 0
var move = true
export var MainPath = NodePath()
onready var Main = get_node(MainPath)
var speed = 1.0
var spdAmp = Vector2()
var path = PoolVector2Array() setget set_path


var recorddd = Vector2()


func _ready():
	set_process(false)


func _process(delta):
	spdAmp = Main.playerVelocity
	var speedTangent = sqrt(pow(spdAmp.x,2) + pow(spdAmp.y,2))
	var move_distance = speedTangent * delta
	move_along_path(move_distance)


func move_along_path(distance):
	if move == true:
		var start_point = $PlayerBody.global_position
		for i in range(path.size()):
			var distance_to_next = start_point.distance_to(path[0])
			if distance <= distance_to_next and distance > 0.0:
				$PlayerBody.global_position = start_point.linear_interpolate(path[0], distance / distance_to_next)
				break
			elif distance < 0.0:
				$PlayerBody.global_position = path[0]
				set_process(false)
				break
			
			distance -= distance_to_next
			start_point = path[0]
			path.remove(0)


func set_path(value):
	path = value
	if value.size() == 0:
		return
	set_process(true)

func EnterPlayerRange(body):
	move = false

func ExitPlayerRange(body):
	move = true
