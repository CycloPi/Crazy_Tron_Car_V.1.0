extends Control


var direccionArchivo = "res://infojugador.json"
var circuitoSeleccionado

var archivoLeer 
#variables para las vueltas
var tiempoVuelta = 0
var cocheSeleccionado
var fechaPartida
var diccionarioPartida = {"coche": cocheSeleccionado,"circuito": circuitoSeleccionado,"fecha": fechaPartida,"tiempoVuelta": tiempoVuelta}
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
#onready var cocheMiniMapa = get_tree().get_root().get_node("/root/carrera/PosicionSalida/car")
onready var fantasma = get_tree().get_root().get_node("/root/carrera/PosicionSalida/fantasma/fantasma")
onready var fantasmika = get_tree().get_root().get_node("/root/carrera/PosicionSalida/fantasma")
onready var meta = get_tree().get_root().get_node("/root/carrera/PosicionSalida/fantasma/meta")
onready var parcial1 = get_tree().get_root().get_node("/root/carrera/PosicionSalida/fantasma/parcial1")
onready var parcial2 = get_tree().get_root().get_node("/root/carrera/PosicionSalida/fantasma/parcial2")
onready var parcial3 = get_tree().get_root().get_node("/root/carrera/PosicionSalida/fantasma/parcial3")
onready var parcial4 = get_tree().get_root().get_node("/root/carrera/PosicionSalida/fantasma/parcial4")
onready var parcial5 = get_tree().get_root().get_node("/root/carrera/PosicionSalida/fantasma/parcial5")
onready var parcial6 = get_tree().get_root().get_node("/root/carrera/PosicionSalida/fantasma/parcial6")
onready var parcial7 = get_tree().get_root().get_node("/root/carrera/PosicionSalida/fantasma/parcial7")
onready var parcial8 = get_tree().get_root().get_node("/root/carrera/PosicionSalida/fantasma/parcial8")
onready var parcial9 = get_tree().get_root().get_node("/root/carrera/PosicionSalida/fantasma/parcial9")
onready var parcial10 = get_tree().get_root().get_node("/root/carrera/PosicionSalida/fantasma/parcial10")



func _ready():

	set_fixed_process(true)
	#   Funciones CycloPi
	leerJuego()
	datosPartida()
	guardarJuego(diccionarioPaGuardar)
	pass
	
func _fixed_process(delta):
	relogiko()
	salidaFuerza()
	cuentaAtras()
	tiempo_vueltas()
	posicion_miniMapa()
	
	if fantasmika.vueltas > vueltas:
		vueltas += 1
		print("meto paso por meta")
	
	pass
	
	
func posicion_miniMapa():
	#print (posicion0Coche)
	#print (cocheMiniMapa.get_name())
	#print(coche.get_transform().origin)
	var CameraMiniMapa = get_node("MiniMapa/Viewport/CameraMiniMapa")
	var cochePos = CameraMiniMapa.unproject_position(coche.get_transform().origin)
	var fantasmaPos = CameraMiniMapa.unproject_position(fantasma.get_transform().origin)
	var metaPos = CameraMiniMapa.unproject_position(meta.get_transform().origin)
	var parcial1Pos = CameraMiniMapa.unproject_position(parcial1.get_transform().origin)
	var parcial2Pos = CameraMiniMapa.unproject_position(parcial2.get_transform().origin)
	var parcial3Pos = CameraMiniMapa.unproject_position(parcial3.get_transform().origin)
	var parcial4Pos = CameraMiniMapa.unproject_position(parcial4.get_transform().origin)
	var parcial5Pos = CameraMiniMapa.unproject_position(parcial5.get_transform().origin)
	var parcial6Pos = CameraMiniMapa.unproject_position(parcial6.get_transform().origin)
	var parcial7Pos = CameraMiniMapa.unproject_position(parcial7.get_transform().origin)
	var parcial8Pos = CameraMiniMapa.unproject_position(parcial8.get_transform().origin)
	var parcial9Pos = CameraMiniMapa.unproject_position(parcial9.get_transform().origin)
	var parcial10Pos = CameraMiniMapa.unproject_position(parcial10.get_transform().origin)
	
	#print (get_node("MiniMapa/Viewport/CameraMiniMapa").unproject_position(coche.get_transform().origin))
#	print (str(fantasma) + str(fantasma.get_tree()) + str(fantasma.get_filename())) 
	get_node("MiniMapa/Viewport/CameraMiniMapa/coche").set_pos(cochePos)
	get_node("MiniMapa/Viewport/CameraMiniMapa/fantasma").set_pos(fantasmaPos)
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
#	print ("engine force: " +str(coche.engine_force))
	if segundosT == 3:
		coche.engine_force = 100
		banderaEnCarrera = true
	if segundosT < 3 and banderaEnCarrera == false:
		coche.engine_force = 0
		
#	else:	
#		coche.engine_force = fuerzaMotor
#		banderaEnCarrera = true
#		print(coche.engine_force)

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
	archivoLeer = File.new()
	if not archivoLeer.file_exists(direccionArchivo):
		return
	
	archivoLeer.open(direccionArchivo, File.READ)
	var diccionarioLeido = {}
	diccionarioLeido.parse_json(archivoLeer.get_as_text())
#	print(diccionarioLeido.key1)
	diccionarioUltimaPartida = diccionarioLeido.key1
#	print("leeeo")
func datosPartida():	# leer datos actuales de partida 
	cocheSeleccionado = coche.get_child(0).get_name() #paguardar nombre circuito
	circuitoSeleccionado = Global.pista #guardar nobre ccoche
	fechaPartida = OS.get_date(true) #guardar fecha partida
	diccionarioPartida  = {"coche": cocheSeleccionado,"circuito": circuitoSeleccionado,"fecha": fechaPartida}
	#guardopartida datos actuales de partida 
	diccionarioPaGuardar = {"key1": diccionarioPartida}
#	imprimeInfo.set_text("Partida anterior " + str(diccionarioUltimaPartida.fecha.day) + "-" + str(diccionarioUltimaPartida.fecha.month)+"-"+ str(diccionarioUltimaPartida.fecha.year)+ " Circuito: " + str(diccionarioUltimaPartida.circuito) + " Coche: " + str(diccionarioUltimaPartida.coche))
	if not archivoLeer.file_exists(direccionArchivo):
		imprimeInfo.set_text("Bienvenido" )
	else:
		imprimeInfo.set_text("Partida anterior " + str(diccionarioUltimaPartida.fecha.day) + "-" + str(diccionarioUltimaPartida.fecha.month)+"-"+ str(diccionarioUltimaPartida.fecha.year)+ " Circuito: " + str(diccionarioUltimaPartida.circuito) + " Coche: " + str(diccionarioUltimaPartida.coche)+" tiempo: ")
	
	imprimePartidaActual.set_text("Partida actual " + str(diccionarioPartida.fecha.day)+ "-" + str(diccionarioPartida.fecha.month)+"-"+ str(diccionarioPartida.fecha.year)+ " Circuito: " + str(diccionarioPartida.circuito) + " Coche: " + str(diccionarioPartida.coche))
	
