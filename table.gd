extends Node
var rng = RandomNumberGenerator.new()

var pogey = [[
#name
"fuckass1"
,#typing
["epic, swag"]
,#ev, from table (initially)
#HP, ATK, DEF, SP ATK, SP DEF, SPEED
[["ATK",0],["DEF",0],["SP ATK",0],["SP DEF",0],["SPD",0],["HP",0],]
,#iv, rng
#HP, ATK, DEF, SP ATK, SP DEF, SPEED
[["ATK",null],["DEF",null],["SP ATK",null],["SP DEF",null],["SPD",null],["HP",null],]
,#nature + likes/dislikes (Food)
["Rash", ["", 1.1], ["", 0.9], ["",""]]
,#level
50
,#ACTUAL STATS GOD
#HP, ATK, DEF, SP ATK, SP DEF, SPEED
[["ATK",0],["DEF",0],["SP ATK",0],["SP DEF",0],["SPD",0],["HP",0],]
,#ot id
0
,#pokerus
false
,#nickname
"BallMaster"
,#held
0




]]





#https://bulbapedia.bulbagarden.net/wiki/Effort_values
const evDrops = [[["Bulbasaur", "normal"], ["SP ATK", 1]],
[["Ivysaur", "normal"], ["SP ATK", 1], ["SP DEF", 1]],
[["Venusaur", "normal"], ["SP ATK", 2], ["SP DEF", 1]],
[["Venusaur", "mega"], ["SP ATK", 2], ["SP DEF", 1]],
[["Charmander", "normal"], ["SPD", 1]],
[["Charmeleon", "normal"], ["SP ATK", 2], ["SPD", 1]],
[["Squirtle", "normal"], ["DEF", 1]],

[["fuckass1", "normal"], ["SP ATK", 0]],
[["bit and a piece", "normal"], ["ATK", 3]],
[["SimSun", "normal"], ["SPD", 3]],



]

const baseStats = [
["fuckass1",
["ATK", 20], ["DEF", 50], ["SP ATK", 50], ["SP DEF", 50], ["SPD", 40], ["HP", 70]]



]

#IVS ARE RANDOM
#https://bulbapedia.bulbagarden.net/wiki/Individual_values

#iv to stat calc = 
#((((2*Base stat)) + IV (random) + (EV drop / 4)) * Level)/100
#if stat != "HP":
#	(before + 5) * Nature Mod (0.9, 1.0 or 1.1)
#else:
#	before + Level + 10
#
#


#https://bulbapedia.bulbagarden.net/wiki/Nature
#nature affects + or - 10%
const nature = [
["Hardy", null, null, null, null],
["Lonely", "ATK", "DEF", "Spicy", "Sour"],
["Brave", "ATK", "SPD", "Spicy", "Sweet"],
["Adamant", "ATK", "SP ATK", "Spicy", "Dry"],
["Naughty", "ATK", "SP DEF", "Spicy", "Bitter"],
["Bold", "DEF", "ATK", "Sour", "Spicy"],
["Docile", null, null, null, null],
["Relaxed", "DEF", "SPD", "Sour", "Sweet"],
["Impish", "DEF", "SP ATK", "Sour", "Dry"],
["Lax", "DEF", "SP DEF", "Sour", "Bitter"],
["Timid", "SPD", "ATK", "Sweet", "Spicy"],
["Hasty", "SPD", "DEF", "Sweet", "Sour"],
["Serious", null, null, null, null],
["Jolly", "SPD", "SP ATK", "Sweet", "Dry"],
["Naive", "SPD", "SP DEF", "Sweet", "Bitter"],
["Modest", "SP ATK", "ATK", "Dry", "Spicy"],
["Mild", "SP ATK", "DEF", "Dry", "Sour"],
["Quiet", "SP ATK", "SPD", "Dry", "Sweet"],
["Bashful", null, null, null, null],
["Rash", "SP ATK", "SP DEF", "Dry", "Bitter"],
["Calm", "SP DEF", "DEF", "Bitter", "Spicy"],
["Gentle", "SP DEF", "DEF", "Bitter", "Sour"],
["Sassy", "SP DEF", "DEF", "Bitter", "Sweet"],
["Careful", "SP DEF", "SP ATK", "Bitter", "Dry"],
["Quirky", null, null, null, null]
]

func _ready():
	var curr = 0
	baseCalc(curr, pogey)

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		var curr = 0
		_calcBases("SP ATK", curr, pogey)
		
	if Input.is_action_just_pressed("ui_select"):
		var curr = 0
		baseCalc(curr, pogey)


func baseCalc(idx, array):
	var pogeyman = array[idx]
	var pogeyName = pogeyman[0]
	var pogeyType = pogeyman[1]
	var pogeyEV = pogeyman[2]
	var pogeyIV = pogeyman[3]
	var pogeyNature = pogeyman[4]
	var pogeyLevel = pogeyman[5]
	var pogeyStat = pogeyman[6]
	
	var iterateIV = 0
	while iterateIV < array[idx][3].size():
		#if not done yet
		
		if array[idx][3][iterateIV][1] == null:
			rng.randomize()
			array[idx][3][iterateIV][1] = 31
		iterateIV += 1


	var statsToChange = []
	var findName = 0
	while findName < evDrops.size():
		var naeeeme = evDrops[findName][0][0]
		if naeeeme == pogeyName:
			var findStat = 1
			while findStat < evDrops[findName].size():
				statsToChange.append(evDrops[findName][findStat])
				findStat += 1
			break
		findName += 1


	var iterateStatsToChange = 0
	while iterateStatsToChange < statsToChange.size():
		var statChange = statsToChange[iterateStatsToChange][0]
		var iterateEV = 0
		while iterateEV < array[idx][2].size():
			if array[idx][2][iterateEV][0] == statChange:
				array[idx][2][iterateEV][1] = statsToChange[iterateStatsToChange][1]
				break
			iterateEV += 1
		iterateStatsToChange += 1

	var natureId = 0
	if pogeyNature[0] == "":
		rng.randomize()
		var SEED = rng.randi_range(0,1000000)
		natureId = SEED % 25
		pogeyNature[0] = nature[natureId][0]
	if pogeyNature[0] != "":
		var FINDGOD = 0
		while FINDGOD < nature.size():
			if nature[FINDGOD][0] == pogeyNature[0]:
				natureId = FINDGOD
				break
			FINDGOD += 1
		pogeyNature[1][0] = nature[natureId][1]
		if pogeyNature[1][0] == null:
			pogeyNature[1][0] = 1.0
		pogeyNature[2][0] = nature[natureId][2]
		if pogeyNature[2][0] == null:
			pogeyNature[2][0] = 1.0
		pogeyNature[3][0] = nature[natureId][3]
		pogeyNature[3][1] = nature[natureId][4]
		
		
	#find the base for the stat
	var findNameBase = 0
	while findNameBase < baseStats.size():
		var naeeeme = baseStats[findNameBase][0]
		if naeeeme == pogeyName:
			var findStat = 1
			while findStat < baseStats[findNameBase].size():
				pogeyStat[findStat - 1][1] = baseStats[findNameBase][findStat][1]
				findStat += 1
			break
		findNameBase += 1




func _calcBases(stat, idx, array):
	var harnessTheStat = 0
	var pogeymanName = array[idx][0]
	var iterateIV = 0
	var UseIv = 0
	while iterateIV < array[idx][3].size():
		#if not done yet
		
		if array[idx][3][iterateIV][1] == null:
			rng.randomize()
			array[idx][3][iterateIV][1] = rng.randi_range(0,31)
		#while we are at it lets swipe that specific iv we need
		if array[idx][3][iterateIV][0] == stat:
			UseIv = array[idx][3][iterateIV][1]
		iterateIV += 1
	
	
	#find the base for the stat
	var UseBase = 0
	var findNameBase = 0
	var found = false
	while findNameBase < baseStats.size():
		var naeeeme = baseStats[findNameBase][0]
		if naeeeme == pogeymanName:
			var findStat = 1
			while findStat < baseStats[findNameBase].size():
				if baseStats[findNameBase][findStat][0] == stat:
					UseBase = baseStats[findNameBase][findStat][1]
					found = true
					break
				findStat += 1
			break
		if found == true:
			break
		findNameBase += 1


	var iterateEV = 0
	var UseEv = 0
	while iterateEV < array[idx][2].size():
		if array[idx][2][iterateEV][0] == stat:
			UseEv = array[idx][2][iterateEV][1]
			harnessTheStat = iterateEV
			break
		iterateEV += 1


	var natureMod = 0.0
	var checkMod = 1
	while checkMod < array[idx][4].size() - 1:
		if array[idx][4][checkMod][0] == stat:
			natureMod = array[idx][4][checkMod][1]
			break
		checkMod += 1


	var level = array[idx][5]
	
	var before = ((((2*(UseBase))) + UseIv + (float(UseEv) / 4)) * level)/100.0
	
	
	var statNumber = 0
	
	if stat != "HP":
		statNumber = (before + 5) * natureMod
	else:
		statNumber = before + level + 10


	print([String(UseBase) + " base",
String(UseIv) + " iv random",
String(UseEv) + " ev",
String(level) + " level",
String(natureMod) + " mod",
String(before) + " first",
String(statNumber) + " result"]
)
	array[idx][6][harnessTheStat][1] = int(floor(statNumber))
	print(array[idx][6][harnessTheStat][0] + " is now " + String(array[idx][6][harnessTheStat][1] ))
	array[idx][5] += 1
	print("LEVEL is now " + String(array[idx][5]))
