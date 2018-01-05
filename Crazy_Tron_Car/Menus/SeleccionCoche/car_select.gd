extends Control



func _load_scene(car):
	Global.coche = load(car).instance()
	Global.coche.set_name("car")
#	Global.coche.connect("pressed", self, "_back")
	print ("coche seleccionado: " + str(car))
	get_tree().change_scene("res://Menus/SeleccionPista/SeleccionPista.scn")




func _on_van_1_pressed():
	_load_scene("res://Coches/CarBase/car_base.scn")

func _on_van_2_pressed():
	_load_scene("res://Coches/TrailerTruck/trailer_truck.scn")
	
func _on_van_3_pressed():
	_load_scene("res://Coches/Crane/crane.scn")

func _on_cocherally_pressed():
	_load_scene("res://Coches/Coche.Rally/rally.scn")

func _on_van4_pressed():
	_load_scene("res://Coches/coche_platano/coche_platano.scn")
	
func _on_van5_pressed():
	_load_scene("res://Coches/Coche.003clio/clio03.scn")
	
	


func _on_van6_pressed():
	_load_scene("res://Coches/Coche.002flago/flago.scn")
