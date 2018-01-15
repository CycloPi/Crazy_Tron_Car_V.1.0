extends Control


var direccionArchivo = "res://infojugador.json"
var circuitoSeleccionado



var cocheSeleccionado
var fechaPartida
var diccionarioPartida = {"coche": cocheSeleccionado,"circuito": circuitoSeleccionado,"fecha": fechaPartida}
var diccionarioPaGuardar = {"key1": diccionarioPartida}


# variables guardadas
var diccionarioUltimaPartida

# variables info cicloPi
onready var imprimeInfo = get_node("Ultima")
onready var imprimePartidaActual = get_node("info")



#variables para relog
#onready var imprimeTiempo = get_node("SpriteTiempo/Tiempo")
var tiempoInicio = 0
var banderaInicioT = false
var segundosT = 0
var vueltas = 0 
#variables para boqueo Salida
onready var coche = Global.coche.get_node("BODY")
onready var fuerzaMotor = coche.engine_force
var banderaEnCarrera = false
onready var cuentaAtras = get_node("cuentaAtras")


# Variables para minimapa
#onready var posicionCoche = get_node("MiniMapa/Viewport/CameraMiniMapa/posicionCoche")
onready var cocheMiniMapa = get_tree().get_root().get_node("/root/carrera/PosicionSalida/car")

func _ready():
#	print (Global.coche.get_node("BODY").get_name())
	set_fixed_process(true)
#	print("coche " + str(coche.get_name()))
	leerJuego()
#	print(Global.pista)
	#print(get_parent().get_name())

#	print ("leo ultima: ",diccionarioUltimaPartida)
	
	# leer datos actuales de partida 
	cocheSeleccionado = coche.get_child(0).get_name() #paguardar nombre circuito
	circuitoSeleccionado = Global.pista #guardar nobre ccoche
	fechaPartida = OS.get_date(true) #guardar fecha partida
	diccionarioPartida  = {"coche": cocheSeleccionado,"circuito": circuitoSeleccionado,"fecha": fechaPartida}
	#guardopartida datos actuales de partida 
	diccionarioPaGuardar = {"key1": diccionarioPartida}
	
	guardarJuego(diccionarioPaGuardar)
	imprimeInfo.set_text("Anterior" + str(diccionarioUltimaPartida))
	imprimePartidaActual.set_text(("Actual" + str(diccionarioPaGuardar)))
#	if (get_name() == str("truckCicloPi")): # el if creo que no hace falta no se si ponerlo
	pass
	
func _fixed_process(delta):
	
	relogiko()
	salidaFuerza()
	cuentaAtras()
	tiempo_vueltas()
	posicion_miniMapa()
	
	
func posicion_miniMapa():
	#print (posicionCoche)
	#print (cocheMiniMapa.get_name())
	#print(coche.get_transform().origin)
	var cochePos = get_node("MiniMapa/Viewport/CameraMiniMapa").unproject_position(coche.get_transform().origin)
	#print (get_node("MiniMapa/Viewport/CameraMiniMapa").unproject_position(coche.get_transform().origin))
	get_node("MiniMapa/Viewport/CameraMiniMapa/Sprite").set_pos(cochePos)
	pass

func tiempo_vueltas():
	var tiempoveltas
	if banderaEnCarrera == true:
		tiempoveltas = segundosT - 3
#		print ("tiempoveltas",tiempoveltas)

func cuentaAtras():
	if banderaEnCarrera == false:
		cuentaAtras.set_text(str(3-segundosT))	
		
	else:	
#		print ("parar de contar")
		cuentaAtras.hide()


func relogiko():
	if banderaInicioT == false :
		tiempoInicio = OS.get_ticks_msec()
		banderaInicioT = true 
		#mapa = preMapa.instance()
		#get_parent().add_child(mapa)
		
	#print(((OS.get_ticks_msec()-tiempoInicio)/1000))
	segundosT = ((OS.get_ticks_msec()-tiempoInicio)/1000)
#	print(segundosT)
	#imprimeTiempo.set_text(str(int(segundosT))+" s")
#	print (tiempoInicio)
	pass
	
func salidaFuerza():
	if segundosT == 3:
		coche.engine_force = 100
		banderaEnCarrera = true
	if segundosT < 3 and banderaEnCarrera == false:
		coche.engine_force = 0
#	else:	
#		coche.engine_force = fuerzaMotor
#		banderaEnCarrera = true
#		print(coche.engine_force)


func _on_Area_body_enter( body ):
	vueltas += 1
#	print ("vueltas: " + str(vueltas) )
	
	pass


func _on_Back_pressed():
	
	get_tree().get_root().get_node("carrera").queue_free()
	get_tree().change_scene("res://Menus/M-Principal/base.tscn")

# funciones de guardar
func guardarJuego(diccionarioGuardar):	
	
	var archivoGuardar = File.new()
	archivoGuardar.open(direccionArchivo, archivoGuardar.WRITE)
	archivoGuardar.store_line(diccionarioGuardar.to_json())
	archivoGuardar.close()	
#	print("guardo")

func leerJuego():  
	var archivoLeer = File.new()
	if not archivoLeer.file_exists(direccionArchivo):
		return
	
	archivoLeer.open(direccionArchivo, File.READ)
	var diccionarioLeido = {}
	diccionarioLeido.parse_json(archivoLeer.get_as_text())
#	print(diccionarioLeido.key1)
	diccionarioUltimaPartida = diccionarioLeido.key1
#	print("leeeo")
