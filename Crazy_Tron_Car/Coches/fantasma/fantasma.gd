extends Spatial

#onready var fantasma_escena = preload("res://fantasma/fantasma.tscn")
var numero_frame = 0
var grabar_coche = true
var fantasma_corre = true
onready var  meta = get_node("meta")
onready var  parcial1 = get_node("parcial1")
onready var  parcial2 = get_node("parcial2")
onready var  parcial3 = get_node("parcial3")

var vueltas = 0

## para que se mueva el cubo y no el nodo principal ###
onready var fantasma_body = get_node("TestCube")

func _ready():
	
	
	GLOBAL_fantasma.load_game()
	#### #### escone la meta del coche, esconde la leyermask (.hide no sive) ####
	meta.set_layer_mask_bit(0,0)
	parcial1.set_layer_mask_bit(0,1)
	parcial2.set_layer_mask_bit(0,0)
	parcial3.set_layer_mask_bit(0,0)
	grabar_coche()
	
#	set_process_input(true)
	set_fixed_process(true)
	


### hace correr al fantasma recorriendo las listas del diccionario con "numero_frame" ###
func fantasma_corre():
#	var nodo_fantasma = get_tree().get_root().get_node("fantasma")
#	# cambiar
	
	if GLOBAL_fantasma.posicion_fantasma_circuito_1_x_0.empty():
		pass
	else:
		fantasma_body.set_global_transform(Transform(
		
		Vector3(GLOBAL_fantasma.posicion_fantasma_circuito_1_x_0[numero_frame] , GLOBAL_fantasma.posicion_fantasma_circuito_1_x_1[numero_frame] , GLOBAL_fantasma.posicion_fantasma_circuito_1_x_2[numero_frame]),
		Vector3(GLOBAL_fantasma.posicion_fantasma_circuito_1_y_0[numero_frame] , GLOBAL_fantasma.posicion_fantasma_circuito_1_y_1[numero_frame] , GLOBAL_fantasma.posicion_fantasma_circuito_1_y_2[numero_frame]),
		Vector3(GLOBAL_fantasma.posicion_fantasma_circuito_1_z_0[numero_frame] , GLOBAL_fantasma.posicion_fantasma_circuito_1_z_1[numero_frame] , GLOBAL_fantasma.posicion_fantasma_circuito_1_z_2[numero_frame]),
		Vector3(GLOBAL_fantasma.origen_fantasma_circuito_1_0[numero_frame],GLOBAL_fantasma.origen_fantasma_circuito_1_1[numero_frame],GLOBAL_fantasma.origen_fantasma_circuito_1_2[numero_frame])))
		
		if numero_frame >= GLOBAL_fantasma.posicion_fantasma_circuito_1_x_0.size()-1:
			pass
		else: numero_frame +=1

func grabar_coche():	
	### apendiza a las listas del diccionario la matrix3x4 ####
	var coche_nodo = get_tree().get_root().get_node("carrera/PosicionSalida/car/BODY")
#	
	GLOBAL_fantasma.posicion_coche_x_0.append(coche_nodo.get_global_transform().basis.x[0])
	GLOBAL_fantasma.posicion_coche_x_1.append(coche_nodo.get_global_transform().basis.x[1])
	GLOBAL_fantasma.posicion_coche_x_2.append(coche_nodo.get_global_transform().basis.x[2])
	
	GLOBAL_fantasma.posicion_coche_y_0.append(coche_nodo.get_global_transform().basis.y[0])
	GLOBAL_fantasma.posicion_coche_y_1.append(coche_nodo.get_global_transform().basis.y[1])
	GLOBAL_fantasma.posicion_coche_y_2.append(coche_nodo.get_global_transform().basis.y[2])
	
	GLOBAL_fantasma.posicion_coche_z_0.append(coche_nodo.get_global_transform().basis.z[0])
	GLOBAL_fantasma.posicion_coche_z_1.append(coche_nodo.get_global_transform().basis.z[1])
	GLOBAL_fantasma.posicion_coche_z_2.append(coche_nodo.get_global_transform().basis.z[2])
	
	GLOBAL_fantasma.origen_coche_0.append(coche_nodo.get_global_transform().origin[0])
	GLOBAL_fantasma.origen_coche_1.append(coche_nodo.get_global_transform().origin[1])
	GLOBAL_fantasma.origen_coche_2.append(coche_nodo.get_global_transform().origin[2])
	
#func _input(event):
#	
#	if (Input.is_action_pressed("aparece_fantasma_j")):	
#		
#		fantasma_corre = true
#	
#	if (Input.is_action_pressed("salvar")):
#		GLOBAL_fantasma.save_game()	
#	
#	if (Input.is_action_pressed("grabar h")):
#		grabar_coche = true
	
func _fixed_process(delta):
	if grabar_coche:
		grabar_coche()
		
	if fantasma_corre:
		fantasma_corre()

# area que hace que deje de grabar las posiciones del coche  "meta"
func _on_meta_body_enter( body ):
 #deja de grabar y sustituye el tiempo del fantasma por el del coche si este es menor 
	numero_frame = 0
	
#	grabar_coche = false
#	
	if GLOBAL_fantasma.posiciones_fantasma_circuito_1["posicion_fantasma_circuito_1_x_0"].empty() or GLOBAL_fantasma.posiciones_coche["posicion_coche_x_0"].size() < GLOBAL_fantasma.posiciones_fantasma_circuito_1["posicion_fantasma_circuito_1_x_0"].size():
		GLOBAL_fantasma.posicion_coche_x_0.empty()
		GLOBAL_fantasma.posicion_coche_x_1.empty()
		GLOBAL_fantasma.posicion_coche_x_2.empty()
	
		GLOBAL_fantasma.posicion_coche_y_0.empty()
		GLOBAL_fantasma.posicion_coche_y_1.empty()
		GLOBAL_fantasma.posicion_coche_y_2.empty()
	
		GLOBAL_fantasma.posicion_coche_z_0.empty()
		GLOBAL_fantasma.posicion_coche_z_1.empty()
		GLOBAL_fantasma.posicion_coche_z_2.empty()
	
		GLOBAL_fantasma.origen_coche_0.empty()
		GLOBAL_fantasma.origen_coche_1.empty()
		GLOBAL_fantasma.origen_coche_2.empty()
	
		print("se_graba")
		GLOBAL_fantasma.posiciones_fantasma_circuito_1["posicion_fantasma_circuito_1_x_0"] = GLOBAL_fantasma.posicion_coche_x_0
		GLOBAL_fantasma.posiciones_fantasma_circuito_1["posicion_fantasma_circuito_1_x_1"] = GLOBAL_fantasma.posicion_coche_x_1
		GLOBAL_fantasma.posiciones_fantasma_circuito_1["posicion_fantasma_circuito_1_x_2"] = GLOBAL_fantasma.posicion_coche_x_2
	
		GLOBAL_fantasma.posiciones_fantasma_circuito_1["posicion_fantasma_circuito_1_y_0"] = GLOBAL_fantasma.posicion_coche_y_0
		GLOBAL_fantasma.posiciones_fantasma_circuito_1["posicion_fantasma_circuito_1_y_1"] = GLOBAL_fantasma.posicion_coche_y_1
		GLOBAL_fantasma.posiciones_fantasma_circuito_1["posicion_fantasma_circuito_1_y_2"] = GLOBAL_fantasma.posicion_coche_y_2
		
		GLOBAL_fantasma.posiciones_fantasma_circuito_1["posicion_fantasma_circuito_1_z_0"] = GLOBAL_fantasma.posicion_coche_z_0
		GLOBAL_fantasma.posiciones_fantasma_circuito_1["posicion_fantasma_circuito_1_z_1"] = GLOBAL_fantasma.posicion_coche_z_1
		GLOBAL_fantasma.posiciones_fantasma_circuito_1["posicion_fantasma_circuito_1_z_2"] = GLOBAL_fantasma.posicion_coche_z_2
		
		GLOBAL_fantasma.posiciones_fantasma_circuito_1["origen_fantasma_circuito_1_0"] = GLOBAL_fantasma.origen_coche_0
		GLOBAL_fantasma.posiciones_fantasma_circuito_1["origen_fantasma_circuito_1_1"] = GLOBAL_fantasma.origen_coche_1
		GLOBAL_fantasma.posiciones_fantasma_circuito_1["origen_fantasma_circuito_1_2"] = GLOBAL_fantasma.origen_coche_2
		
		GLOBAL_fantasma.save_game()
#		print("entro")


	parcial1.set_layer_mask_bit(0,1)
	parcial3.set_layer_mask_bit(0,0)
	print ("meta")
	vueltas += 1
	print ("vueltas: " + str(vueltas))
	
	
#
#
func _on_parcial1_body_enter( body ):
	#### hace vidible  la meta del coche, hace visible la leyermask  ####
	parcial2.set_layer_mask_bit(0,1)
	meta.set_layer_mask_bit(0,0)
	print ("parcial1")
	pass

func _on_parcial2_body_enter( body ):
	parcial3.set_layer_mask_bit(0,1)
	parcial1.set_layer_mask_bit(0,0)
	print ("parcial2")
	pass # replace with function body
	
func _on_parcial3_body_enter( body ):
	meta.set_layer_mask_bit(0,1)
	parcial2.set_layer_mask_bit(0,0)
	print ("parcial3")
	pass # replace with function body

