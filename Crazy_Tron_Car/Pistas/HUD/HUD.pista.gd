extends Control

# variables guardadas
var diccionarioUltimaPartida
var direccionArchivo = "res://infojugador.json"
var circuitoSeleccionado
var archivoLeer 

#variables para las vueltas
var tiempoVuelta = 0
var cocheSeleccionado
var fechaPartida
var diccionarioPartida = {"coche": cocheSeleccionado,"circuito": circuitoSeleccionado,"fecha": fechaPartida}
var diccionarioTiempos = {"Tvuela": tiempoVuelta}
var diccionarioUltimosTiempos
var diccionarioPaGuardar = {"partida": diccionarioPartida, "tiempos":diccionarioTiempos}

# variables info cicloPi
onready var imprimeInfo = get_node("Ultima")
onready var imprimePartidaActual = get_node("info")

# var para marcador de tiempos:
var BanderaMarcador = false
var preEsceMarcador = preload("res://Pistas/HUD/MarcadorRetro/MarcadoRetroEscena.tscn")
var MarcadoTiempo

var InicioTempo3s = 0



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


onready var parcial1Volante = get_node("MiniMapa/Viewport/CameraMiniMapa/metaVolante1")
onready var parcial2Volante = get_node("MiniMapa/Viewport/CameraMiniMapa/metaVolante2")
onready var parcial3Volante = get_node("MiniMapa/Viewport/CameraMiniMapa/metaVolante3")
onready var parcial4Volante = get_node("MiniMapa/Viewport/CameraMiniMapa/metaVolante4")
onready var parcial5Volante = get_node("MiniMapa/Viewport/CameraMiniMapa/metaVolante5")
onready var parcial6Volante = get_node("MiniMapa/Viewport/CameraMiniMapa/metaVolante6")
onready var parcial7Volante = get_node("MiniMapa/Viewport/CameraMiniMapa/metaVolante7")
onready var parcial8Volante = get_node("MiniMapa/Viewport/CameraMiniMapa/metaVolante8")
onready var parcial9Volante = get_node("MiniMapa/Viewport/CameraMiniMapa/metaVolante9")
onready var parcial10Volante = get_node("MiniMapa/Viewport/CameraMiniMapa/metaVolante10")
onready var metaVolante = get_node("MiniMapa/Viewport/CameraMiniMapa/metaVolante")

func posicion_miniMapa():
	#print (posicion0Coche)
	#print (cocheMiniMapa.get_name())
	#print(coche.get_transform().origin)
	var CameraMiniMapa = get_node("MiniMapa/Viewport/CameraMiniMapa")
	var cochePos = CameraMiniMapa.unproject_position(coche.get_transform().origin)
	var fantasmaPos = CameraMiniMapa.unproject_position(fantasma.get_transform().origin)
	var cocheRot = coche.get_rotation_deg().y
	
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
	get_node("MiniMapa/Viewport/CameraMiniMapa/coche").set_rotd(cocheRot)
	get_node("MiniMapa/Viewport/CameraMiniMapa/fantasma").set_pos(fantasmaPos)
#	print (cocheRot)
	parcial1Volante.set_pos(Vector2(-20,-20))
	parcial2Volante.set_pos(parcial2Pos)
	parcial3Volante.set_pos(parcial3Pos)
	parcial4Volante.set_pos(parcial4Pos)
	parcial5Volante.set_pos(parcial5Pos)
	parcial6Volante.set_pos(parcial6Pos)
	parcial7Volante.set_pos(parcial7Pos)
	parcial8Volante.set_pos(parcial8Pos)
	parcial9Volante.set_pos(parcial9Pos)
	parcial10Volante.set_pos(parcial10Pos)
	metaVolante.set_pos(metaPos)
	
	
#	metaVolante.hide()
#	parcial1Volante.hide()
#	parcial2Volante.hide()
#	parcial3Volante.hide()
#	parcial4Volante.hide()
#	parcial5Volante.hide()
#	parcial6Volante.hide()
#	parcial7Volante.hide()
#	parcial8Volante.hide()
#	parcial9Volante.hide()
#	parcial10Volante.hide()
	pass



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
	#funcion en pruebas:
	# No no no funciona el contador de vueltas del fantasma
	# solo marca la primera: 
	#
	#print(fantasmika.vueltas)
	#
	# Solo cuenta una vez , No entra en el area lo he emirado
	# grabar tiempo
	grabarTiempos()
	
	if segundosT - InicioTempo3s == 4 and BanderaMarcador :
		MarcadoTiempo.free()
		BanderaMarcador = false
		print("ahora")
	
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
		
		
		# funcion para sacar el marcador
		if BanderaMarcador == false:
			print("saca el cartel último tiempo")
			MarcadoTiempo = preEsceMarcador.instance()
			get_parent().add_child(MarcadoTiempo)
			MarcadoTiempo.set_pos(Vector2(0,200))
			BanderaMarcador = true
			InicioTempo3s = segundosT
			print(diccionarioUltimosTiempos)
			MarcadoTiempo.get_node("Informacion").set_text("ÚT: "+str(diccionarioUltimosTiempos)+" s")
#			MarcadoTiempo.get_node("Informacion").set_text("Wellcome")
			
			
			if not archivoLeer.file_exists(direccionArchivo):
				MarcadoTiempo.get_node("Informacion").set_text("Wellcome")
#				imprimeInfo.set_text("Bienvenido" )

#			else:
#				MarcadoTiempo.get_node("Informacion").set_text("ÚT: "+str(diccionarioUltimosTiempos.Tvuela)+" s")
	
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
#	print(diccionarioLeido.key1p)
	diccionarioUltimaPartida = diccionarioLeido.partida
	print("tiempoleido")
	diccionarioUltimosTiempos = diccionarioLeido.tiempos
	print(diccionarioUltimosTiempos)
#	print("leeeo")


func datosPartida():	# leer datos actuales de partida 
	cocheSeleccionado = coche.get_child(0).get_name() #paguardar nombre circuito
	circuitoSeleccionado = Global.pista #guardar nobre ccoche
	fechaPartida = OS.get_date(true) #guardar fecha partida
	diccionarioPartida  = {"coche": cocheSeleccionado,"circuito": circuitoSeleccionado,"fecha": fechaPartida, "tiempoVuelta": tiempoVuelta}
	#guardopartida datos actuales de partida 
	
	diccionarioPaGuardar.partida = diccionarioPartida
#	imprimeInfo.set_text("Partida anterior " + str(diccionarioUltimaPartida.fecha.day) + "-" + str(diccionarioUltimaPartida.fecha.month)+"-"+ str(diccionarioUltimaPartida.fecha.year)+ " Circuito: " + str(diccionarioUltimaPartida.circuito) + " Coche: " + str(diccionarioUltimaPartida.coche))
	if not archivoLeer.file_exists(direccionArchivo):
		imprimeInfo.set_text("Bienvenido" )
	else:
		imprimeInfo.set_text("Partida anterior " + str(diccionarioUltimaPartida.fecha.day) + "-" + str(diccionarioUltimaPartida.fecha.month)+"-"+ str(diccionarioUltimaPartida.fecha.year)+ " Circuito: " + str(diccionarioUltimaPartida.circuito) + " Coche: " + str(diccionarioUltimaPartida.coche)+" tiempo: ")
	
	imprimePartidaActual.set_text("Partida actual " + str(diccionarioPartida.fecha.day)+ "-" + str(diccionarioPartida.fecha.month)+"-"+ str(diccionarioPartida.fecha.year)+ " Circuito: " + str(diccionarioPartida.circuito) + " Coche: " + str(diccionarioPartida.coche))

func grabarTiempos():
	if fantasmika.vueltas > vueltas:
		tiempoVuelta = segundosT
		vueltas += 1
		diccionarioTiempos.Tvuela = tiempoVuelta
		diccionarioPaGuardar.tiempos = diccionarioTiempos
		guardarJuego(diccionarioPaGuardar)
		print("meto paso por meta, tiempo de vuelta: " + str(tiempoVuelta) +" segundos." )
	
