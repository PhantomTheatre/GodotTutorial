extends Node

var PathToFile

var saved_info = {
	#Game Info
	"level": "",
	#Settings Info
	"selectedlanguage" : "English",
	"smile": ""
	}
var language = {}

func save():
	var file = File.new()
	file.open("res://Saves/" + Global.SelectedSave, File.WRITE)
	file.store_string(to_json(saved_info))
	file.close()

func loading(view = "Game"):
	var file = File.new()
	if view == "Languages":  
		PathToFile = ("res://Saves/Languages/" + saved_info["selectedlanguage"] + ".json")
	elif view == "Game":
		PathToFile = "res://Saves/" + Global.SelectedSave
	file.open(PathToFile, File.READ)
	var data = parse_json(file.get_as_text())
	file.close()
	if typeof(data) == TYPE_DICTIONARY:
		if view == "Languages":   language = data
		elif view == "Game":      saved_info = data
			
func convertering(path):
	var file = File.new()
	file.open(path, File.READ)
	var data = parse_json(file.get_as_text())
	file.open(path.get_basename() + ".json", File.WRITE)
	file.store_string(to_json(data))
	file.close()
	#erase
