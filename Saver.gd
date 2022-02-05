extends Node

var PathToFile

var game_info = {
	"level": "",
	"x": "0",
	}
var settings_info = {
	"selectedlanguage" : "English",
	"smile": ""
	}
var language = {}

func Save_Game(Name = "Empty"):
	var file = File.new()
	file.open("res://Saves/" + Name + ".json", File.WRITE)
	file.store_string(to_json(game_info))
	file.close()
func Load_Game(Name):
	var file = File.new()
	PathToFile = "res://Saves/" + Global.SelectedSave + ".json"
	file.open(PathToFile, File.READ)
	var data = parse_json(file.get_as_text())
	file.close()
	if typeof(data) == TYPE_DICTIONARY:
		game_info = data
func Load_Language():
	var file = File.new()
	PathToFile = ("res://Saves/Languages/" + settings_info["selectedlanguage"] + ".json")
	file.open(PathToFile, File.READ)
	var data = parse_json(file.get_as_text())
	file.close()
	if typeof(data) == TYPE_DICTIONARY:
		game_info = data
			
func convertering(path):
	var file = File.new()
	file.open(path, File.READ)
	var data = parse_json(file.get_as_text())
	file.open(path.get_basename() + ".json", File.WRITE)
	file.store_string(to_json(data))
	file.close()
	#erase
