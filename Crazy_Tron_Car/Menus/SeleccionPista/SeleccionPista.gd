extends Control

var carrera 



func _load_scene(road,fantasma_escena):
	carrera = load(road).instance()
	Global.pista = carrera.get_name()
	carrera.set_name("carrera")
#	print ("pista seleccionada: " + str(road))
#	print("pista "+ str(carrera))
	carrera.get_node("PosicionSalida").add_child(Global.coche)
	get_parent().add_child(carrera)
	
#	var fantasma = 
#	get_parent().add_child(fantasma)
	carrera.get_node("PosicionSalida").add_child(load(fantasma_escena).instance())
	get_parent().add_child(carrera)

	get_tree().get_root().get_node("SeleccionPista").queue_free()

### carga el diccionario y instancia la escena del fantasma ###

	
	
	
	
# Atras Seleccion de coche
func _on_Back_pressed():
	get_tree().change_scene("res://Menus/SeleccionCoche/car_select.scn")

	
# Al menu principal
func _on_MenuPrincipal_pressed():
	get_tree().change_scene("res://Menus/M-Principal/base.tscn")



# Seleccionar pista Truck Town
func _on_Pista_2_pressed():
	_load_scene("res://Pistas/TruckTown/truck_scene.scn","res://Coches/fantasma/fantasma.tscn")
	
# Seleccionar pista Jarama
func _on_Pista_1_pressed():
	_load_scene("res://Pistas/Jarama/jarama_scene.scn","res://Coches/fantasma/fantasma.tscn")
	
# Seleccionar pista Rosco Campero
func _on_Pista3_pressed():
	_load_scene("res://Pistas/RoscoCampero/RoscoCampero_Scene.tscn","res://Coches/fantasma/fantasma.tscn")
	
# Seleccionar pista Platano
func _on_Pista4_pressed():
	_load_scene("res://Pistas/circuito_platano/terreno.tscn","res://Coches/fantasma/fantasma.tscn")
	