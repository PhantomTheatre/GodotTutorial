extends Node

var game_info = {
	"level": 0,
	"x": 0,
	
	"datetime": 0
	}
var settings_info = {
	"selectedlanguage" : "English",
	"smile": ""
	}
var language = {}

var sortdates = []
var sortfiles = []

func Save_Game(Name = "Empty"):
	game_info["datetime"] = OS.get_datetime()
	var file = File.new()
	file.open("res://Saves/" + Name + ".json", File.WRITE)
	file.store_string(to_json(game_info))
	file.close()

func Sorted_Loading(sort = true, PathToDir = "res://Saves/"):
	sortfiles = []
	sortdates = []
	var dirsave = Directory.new()
	dirsave.open(PathToDir)
	dirsave.list_dir_begin(true, false)
	var file_name = dirsave.get_next()
	var file =  File.new()
	var dates = []
	var files = []
	while file_name != "":
		if file_name.get_extension() == "json":
			var PathToFile = "res://Saves/" + file_name
			file.open(PathToFile, File.READ)
			var date = (parse_json(file.get_as_text()))["datetime"]
			dates.append(date)
			files.append(file_name)
			file.close()
			file_name = dirsave.get_next()
		else: file_name = dirsave.get_next()
	
	#Sorting by date
	if sort == true:
		var order = {"year" : 31536000, "month" : 2419200, "day" : 80000, "hour" : 3600, "minute" : 60, "second" : 1}	#Iteration order and number of seconds
		var DiS = dates.duplicate(true)		#Dates in second; deep = True
		for i in DiS:
			for n in order:
				i[n] = i[n] * order.get(n)
			DiS[DiS.find(i)] = i["year"] + i["month"] + i["day"] + i["hour"] + i["minute"] + i["second"]
		var minc = 0	#Competition for much little number
		while files.size() > 0:
			for i in DiS:
				if minc == 0 or i > minc:
					minc = i
			for i in DiS:
				if i == minc:
					sortdates.append(dates[DiS.find(i)])
					sortfiles.append(files[DiS.find(i)])
					dates.pop_at(DiS.find(i))
					files.pop_at(DiS.find(i))
					DiS.pop_at(DiS.find(i))
					minc = 0
	else: 
		sortdates = dates
		sortfiles = files
			
			
func Load_Game(Name):
	var file = File.new()
	var PathToFile = "res://Saves/" + Global.SelectedSave + ".json"
	file.open(PathToFile, File.READ)
	var data = parse_json(file.get_as_text())
	file.close()
	if typeof(data) == TYPE_DICTIONARY:
		game_info = data
func Load_Language():
	var file = File.new()
	var PathToFile = ("res://Saves/Languages/" + settings_info["selectedlanguage"] + ".json")
	file.open(PathToFile, File.READ)
	var data = parse_json(file.get_as_text())
	file.close()
	if typeof(data) == TYPE_DICTIONARY:
		language = data
			
func convertering(path):
	var file = File.new()
	file.open(path, File.READ)
	var data = parse_json(file.get_as_text())
	file.open(path.get_basename() + ".json", File.WRITE)
	file.store_string(to_json(data))
	file.close()
