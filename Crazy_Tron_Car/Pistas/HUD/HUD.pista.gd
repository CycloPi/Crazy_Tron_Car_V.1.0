extends Control


onready var coche = Global.coche.get_node("BODY")
#variables para relog
#onready var imprimeTiempo = get_node("SpriteTiempo/Tiempo")
var tiempoInicio = 0
var banderaInicioT = false
var segundosT = 0
var vueltas = 0 
#variables para boqueo Salida
onready var fuerzaMotor = coche.engine_force
var banderaEnCarrera = false
onready var cuentaAtras = get_node("cuentaAtras")

func _ready():
#	print (Global.coche.get_node("BODY").get_name())

	set_fixed_process(true)
#	print("coche " + str(coche.get_name()))
	


	pass
	
func _fixed_process(delta):
	
	relogiko()
	salidaFuerza()
	cuentaAtras()
	tiempo_vueltas()


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
	if segundosT < 3 and banderaEnCarrera == false:
		coche.engine_force = 0
	else:	
		coche.engine_force = fuerzaMotor
		banderaEnCarrera = true
#		print(coche.engine_force)


func _on_Area_body_enter( body ):
	vueltas += 1
#	print ("vueltas: " + str(vueltas) )
	
	pass


func _on_Back_pressed():
	
	get_tree().get_root().get_node("carrera").queue_free()
	get_tree().change_scene("res://Menus/M-Principal/base.tscn")

